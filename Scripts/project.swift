#!/usr/bin/env beak run --path

// MARK: - Script Dependencies
// beak: kareman/SwiftShell @ .upToNextMajor(from: "4.1.2")
// beak: onevcat/Rainbow @ .upToNextMajor(from: "3.1.2")

import Foundation
import Rainbow
import SwiftShell

// MARK: - Runnable Tasks
public func setup(name: String, orga: String) throws {
    // delete unnecessary files
    for fileToDelete in ["README.md", "LICENSE", "Logo.png"] {
        try execute(bash: "rm \(fileToDelete)")
    }

    // rename sample files to be actual files
    for sampleFile in ["README.md.sample", "LICENSE.sample"] {
        try execute(bash: "mv \(sampleFile) \(sampleFile.replacingOccurrences(of: ".sample", with: ""))")
    }

    // replace name & orga in project file contents
    try replaceFileContentOccurences(of: "NewProjectTemplate", with: name)
    try replaceFileContentOccurences(of: "Jamit Labs GmbH", with: orga)

    // rename files with new name
    // TODO: not yet implemented

    // install tools & dependencies
    try execute(bash: "tools install")
    try execute(bash: "deps install")

    // open project in xcode
    if FileManager.default.fileExists(atPath: "\(name).xcworkspace") {
        try execute(bash: "open \(name).xcworkspace")
    } else {
        try execute(bash: "open \(name).xcodeproj")
    }
}

// MARK: - Helpers
private func execute(bash command: String) throws {
    print("⏳ Executing '\(command.italic.lightYellow)'".bold)
    try runAndPrint(bash: command)
}

private func replaceFileContentOccurences(of stringToReplace: String, with replacement: String) throws {
    try execute(bash: "LC_ALL=C find . -d 1 -type f -exec sed -i '' 's/\(stringToReplace)/\(replacement)/g' {} \\;")

    for subfolder in ["App", "Tests", "UITests", "NewProjectTemplate.xcodeproj"] {
        try execute(bash: "LC_ALL=C find . -regex '\\./\(subfolder)/.*' -type f -exec sed -i '' 's/\(stringToReplace)/\(replacement)/g' {} \\;")
    }
}
