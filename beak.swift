// beak: kareman/SwiftShell @ .upToNextMajor(from: "4.0.0")
// beak: sharplet/Regex @ .upToNextMajor(from: "1.1.0")
// beak: kylef/PathKit @ .upToNextMajor(from: "0.9.0")
// beak: onevcat/Rainbow @ .upToNextMajor(from: "3.0.3")

import Foundation
import SwiftShell
import Regex
import PathKit
import Rainbow

// MARK: - Tasks
/// Initializes the project with the given info.
public func initialize(projectName: String) throws {
    try ["README.md", "Logo.png"].forEach { try deleteFile($0) }
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

    filesToReplaceContent += try Path.glob("Sources/**/*.swift")
    filesToReplaceContent += try Path.glob("Tests/**/*.swift")
    filesToReplaceContent += try Path.glob("UI Tests/**/*.swift")

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
