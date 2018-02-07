// beak: kareman/SwiftShell @ .upToNextMajor(from: "4.0.1")
// beak: sharplet/Regex @ .upToNextMajor(from: "1.1.0")
// beak: kylef/PathKit @ .upToNextMajor(from: "0.9.0")
// beak: onevcat/Rainbow @ .upToNextMajor(from: "3.0.3")

import Foundation
import SwiftShell
import Regex
import PathKit
import Rainbow

// MARK: - Helpers
private func deleteFile(_ fileName: String) throws {
    let command = "[ ! -e \(fileName) ] || rm \(fileName)"
    print("Deleting file '\(fileName)': '\(command)'", level: .info)
    try runAndPrint(bash: command)
}

private func renameProject(from oldName: String, to newName: String) throws {
    var filesToReplaceContent: [Path] = [
        Path(oldName + ".xcodeproj/project.pbxproj"),
        Path(oldName + ".xcodeproj/project.xcworkspace/contents.xcworkspacedata"),
        Path(oldName + ".xcodeproj/project.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings"),
        Path(oldName + ".xcodeproj/xcshareddata/xcschemes/\(oldName).xcscheme")
    ]

    filesToReplaceContent += Path.glob("Sources/**/*.swift")
    filesToReplaceContent += Path.glob("Tests/**/*.swift")
    filesToReplaceContent += Path.glob("UI Tests/**/*.swift")

    try filesToReplaceContent.forEach { swiftFilePath in
        try replaceInFile(fileUrl: swiftFilePath.url, regex: try Regex(string: oldName), replacement: newName)
    }

    let oldSchemePath = "\(oldName).xcodeproj/xcshareddata/xcschemes/\(oldName).xcscheme"
    let newSchemePath = "\(oldName).xcodeproj/xcshareddata/xcschemes/\(newName).xcscheme"
    try runAndPrint(bash: "mv \(oldSchemePath) \(newSchemePath)")
    try runAndPrint(bash: "mv \(oldName).xcodeproj/ \(newName).xcodeproj/")
}

private func replaceInFile(fileUrl: URL, regex: Regex, replacement: String) throws {
    print("Replacing occurences of regex '\(regex)' in file '\(fileUrl.lastPathComponent)' with '\(replacement)' ...", level: .info)
    var content = try String(contentsOf: fileUrl, encoding: .utf8)
    content.replaceAll(matching: regex, with: replacement)
    try content.write(to: fileUrl, atomically: false, encoding: .utf8)
}

private func replaceInFile(fileUrl: URL, substring: String, replacement: String) throws {
    print("Replacing occurences of substring '\(substring)' in file '\(fileUrl.lastPathComponent)' with '\(replacement)' ...", level: .info)
    var content = try String(contentsOf: fileUrl, encoding: .utf8)
    content = content.replacingOccurrences(of: substring, with: replacement)
    try content.write(to: fileUrl, atomically: false, encoding: .utf8)
}

private enum Tool: String {
    case homebrew = "brew"
    case bartycrouch
    case carthage

    var isMissing: Bool {
        return run("which", rawValue).stdout.isEmpty
    }

    func install() throws {
        switch self {
        case .homebrew:
            let installCommand = "/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
            print("Installing Homebrew: '\(installCommand)'", level: .info)
            try runAndPrint(bash: installCommand)

        default:
            try installViaHomebrew()
        }
    }

    private func installViaHomebrew() throws {
        let installCommand = "brew install \(rawValue)"
        print("Installing \(rawValue) via Homebrew: '\(installCommand)'", level: .info)
        try runAndPrint(bash: installCommand)
    }
}

private enum PrintLevel {
    case info
    case warning
    case error
}

private func print(_ message: String, level: PrintLevel) {
    switch level {
    case .info:
        print("ℹ️ ", message.lightBlue)

    case .warning:
        print("⚠️ ", message.yellow)

    case .error:
        print("❌ ", message.red)
    }
}

private func installMissingTools(_ tools: [Tool]) throws {
    if Tool.homebrew.isMissing {
        try Tool.homebrew.install()
    }

    try tools.filter { $0.isMissing }.forEach { try $0.install() }
}

private let semanticVersionRegex = Regex("(\\d+)\\.(\\d+)\\.(\\d+)\\s")

private struct SemanticVersion: Comparable, CustomStringConvertible {
    let major: Int
    let minor: Int
    let patch: Int

    init(_ string: String) {
        guard let captures = semanticVersionRegex.firstMatch(in: string)?.captures else {
            fatalError("SemanticVersion initializer was used without checking the structure.")
        }

        major = Int(captures[0]!)!
        minor = Int(captures[1]!)!
        patch = Int(captures[2]!)!
    }

    static func < (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        guard lhs.major == rhs.major else { return lhs.major < rhs.major }
        guard lhs.minor == rhs.minor else { return lhs.minor < rhs.minor }
        return lhs.patch < rhs.patch
    }

    static func == (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch == rhs.patch
    }

    var description: String {
        return "\(major).\(minor)"
    }
}

private func appendEntryToCartfile(_ tagline: String?, _ githubSubpath: String, _ version: String) throws {
    let comment = tagline != nil ? "# \(tagline!)\n" : ""
    let repoSpecifier = "github \"\(githubSubpath)\""
    let versionSpecifier: String = {
        guard version != "latest" else {
            let tagListCommand = "git ls-remote --tags https://github.com/\(githubSubpath).git"
            let commandOutput = run(bash: tagListCommand).stdout
            let availableSemanticVersions = semanticVersionRegex.allMatches(in: commandOutput).map { SemanticVersion($0.matchedString) }
            guard !availableSemanticVersions.isEmpty else {
                print("Dependency '\(githubSubpath)' has no tagged versions.", level: .error)
                fatalError()
            }
            let latestVersion = availableSemanticVersions.sorted().last!
            return " ~> \(latestVersion)"
        }

        return " ~> \(version)"
    }()

    let textToAddToCartfile = "\n\(comment)\(repoSpecifier)\(versionSpecifier)\n"

    let command = "echo '\(textToAddToCartfile)' >> Cartfile"
    print("Adding entry to Cartfile with: '\(command)'", level: .info)
    try runAndPrint(bash: command)
}

private func fetchGitHubTagline(subpath: String) throws -> String? {
    let taglineRegex = Regex("<meta name=\"description\" content=\"([^\"]*)\">")
    let url = URL(string: "https://github.com/\(subpath)")!
    let html = try String(contentsOf: url, encoding: .utf8)
    guard let firstMatch = taglineRegex.firstMatch(in: html) else { return nil }
    guard let firstCapture = firstMatch.captures.first else { return nil }
    return firstCapture!
}

private func pathOfXcodeProject() -> Path {
    return Path.current.glob("*.xcodeproj").first!
}

typealias Framework = (identifier: String, name: String)

private func pbxProjectFilePath() -> Path {
    return pathOfXcodeProject() + Path("project.pbxproj")
}

private func pbxProjectFileContent() throws -> String {
    return try pbxProjectFilePath().read(.utf8)
}

private func appFrameworks() throws -> [Framework] {
    let frameworkInfoRegex = Regex("\\s*(\\S{24}) \\/\\* ([^\\*]+) \\*\\/,")

    let appFrameworksRegex = Regex("823F74231ED863520022317D \\/\\* App \\*\\/ = \\{\\s*isa = PBXGroup;[^\\(]*children = \\(((?:\\s*\\S{24} \\/\\* [^\\*]+ \\*\\/,)*)")
    let appFrameworksContent = appFrameworksRegex.firstMatch(in: try pbxProjectFileContent())!.captures.first!!
    return frameworkInfoRegex.allMatches(in: appFrameworksContent).map { (identifier: $0.captures[0]!, name: $0.captures[1]!) }
}

private func newFrameworkCopyContent(frameworks: [Framework]) throws -> String {
    return "\n" + frameworks.map { "\t\t\t\t\"$(SRCROOT)/Carthage/Build/iOS/\($0.name)\"," }.joined(separator: "\n")
}

// MARK: - Tasks
/// Initializes the project with the given info.
public func initialize(projectName: String) throws {
    try ["README.md", "LICENSE.md", "Logo.png"].forEach { try deleteFile($0) }
    try renameProject(from: "NewProjectTemplate", to: projectName)
    try installDependencies()
}

/// Installs project dependencies.
public func installDependencies() throws {
    try installMissingTools([.carthage])

    let command = "carthage bootstrap --platform ios --cache-builds"
    print("Installing dependencies via Carthage: '\(command)'", level: .info)
    try runAndPrint(bash: command)
}

/// Updates project dependencies.
public func updateDependencies() throws {
    try installMissingTools([.carthage])

    let command = "carthage update --platform ios --cache-builds"
    print("Updating dependencies via Carthage: \(command)", level: .info)
    try runAndPrint(bash: command)
}

/// Adds a dependency using the configured package manager.
public func addDependency(github githubSubpath: String, version: String = "latest") throws {
    try installMissingTools([.carthage])
    let tagline = try fetchGitHubTagline(subpath: githubSubpath)
    try appendEntryToCartfile(tagline, githubSubpath, version)
    try updateDependencies()

    print("Please add the new frameworks to your projects 'Carthage >> App' group in the project navigator, then run the following command:", level: .warning)
    print("beak run synchronize", level: .warning)
}

/// Synchronizes dependencies in project navigator and other places in the project file.
public func synchronizeDependencies() throws {
    let appTargetFrameworks = try appFrameworks()

    let frameworkCopyRegex = Regex("823F74211ED8633F0022317D \\/\\* Carthage \\*\\/ = \\{[^\\(]*\\(\\s*\\)\\;\\s*inputPaths = \\(((?:\\s*.\\$\\(SRCROOT\\)[^\\)\\s]*)*)\\s*\\)\\;")
    let frameworkCopyContent = frameworkCopyRegex.firstMatch(in: try pbxProjectFileContent())!.captures.first!!
    let newContent = try newFrameworkCopyContent(frameworks: appTargetFrameworks)
    try replaceInFile(fileUrl: pbxProjectFilePath().url, substring: frameworkCopyContent, replacement: newContent)
}
