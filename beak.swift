#!/usr/bin/env beak run

// MARK: - Script Dependencies
// beak: kareman/SwiftShell @ .upToNextMajor(from: "4.1.2")
// beak: onevcat/Rainbow @ .upToNextMajor(from: "3.1.2")

import Foundation
import Rainbow
import SwiftShell

// MARK: - Runnable Tasks
/// Makes sure all Swift files in the Scripts folder can be run as executables without the `.swift` extension or `beak run` prefix.
public func link() throws {
    let scriptsDirUrl = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("Scripts")

    for filePath in try FileManager.default.contentsOfDirectory(atPath: scriptsDirUrl.path) {
        let fileUrl = scriptsDirUrl.appendingPathComponent(filePath)
        try execute(bash: "chmod +x \(fileUrl.path)")
    }

    for bashConfigFile in [".bash_profile", ".bashrc", ".profile"] {
        let bashConfigUrl = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(bashConfigFile)
        let direnvLine = "eval \"$(direnv hook bash)\""

        if !FileManager.default.fileExists(atPath: bashConfigUrl.path) {
            FileManager.default.createFile(atPath: bashConfigUrl.path, contents: nil)
        }

        if FileManager.default.fileExists(atPath: bashConfigUrl.path) && run(bash: "grep '\(direnvLine)' \(bashConfigUrl.path)").stdout.isEmpty {
            try execute(bash: "echo '\(direnvLine)' >> \(bashConfigUrl.path)")
            try execute(bash: "source \(bashConfigUrl.path)")
        }
    }

    try execute(bash: "direnv allow .")
    try execute(bash: "direnv reload")
}

// MARK: - Helpers
private func execute(bash command: String) throws {
    print("⏳ Executing '\(command.italic.lightYellow)'".bold)
    try runAndPrint(bash: command)
}
