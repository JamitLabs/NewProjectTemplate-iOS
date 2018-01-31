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
        return lhs.major < rhs.major || lhs.minor < rhs.minor || lhs.patch < rhs.patch
    }

    static func == (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch == rhs.patch
    }

    var description: String {
        return "\(major).\(minor)"
    }
}

private func appendEntryToCartfile(_ tagline: String, _ githubSubpath: String, _ version: String) throws {
    let comment = "# \(tagline)\n"
    let repoSpecifier = "github \"\(githubSubpath)\""
    let versionSpecifier: String = {
        guard version != "latest" else {
            let tagListCommand = "git ls-remote --tags https://github.com/\(githubSubpath).git"
            let commandOutput = run(bash: tagListCommand).stdout
            let availableSemanticVersions = semanticVersionRegex.allMatches(in: commandOutput).map { SemanticVersion($0.matchedString) }
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

private func synchronizeCarthageAppGroupWithCopyFrameworksBuildPhase() {
    // TODO: not yet implemented
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
public func addDependency(github githubSubpath: String, tagline: String, version: String = "latest") throws {
    try installMissingTools([.carthage])
    try appendEntryToCartfile(tagline, githubSubpath, version)
    try updateDependencies()

    print("Please add the new frameworks to your projects 'Carthage >> App' group in the project navigator, then press any key to continue.", level: .warning)
    run(bash: "read -n 1 -s")

    print("Synchronizing 'Carthage >> App' group with frameworks in copy build phase.", level: .info)
    synchronizeCarthageAppGroupWithCopyFrameworksBuildPhase()
}

/// Adds a testing dependency using the configured package manager.
public func addTestingDependency(github githubSubpath: String, version: String = "latest") throws {
    // not yet implemented
}
