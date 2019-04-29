#!/usr/bin/env beak run --path

// MARK: - Script Dependencies
// beak: kareman/SwiftShell @ .upToNextMajor(from: "4.1.2")
// beak: onevcat/Rainbow @ .upToNextMajor(from: "3.1.2")

import Foundation
import Rainbow
import SwiftShell
import PackageConfig

// MARK: - Runnable Tasks
/// Updates all dependencies specified in the project according to their version requirements.
public func register() throws {
    try execute(bash: "mkdir -p .git/hooks")

    let preCommitContents: String = """
      #!/bin/bash
      bartycrouch lint --fail-on-warnings
      swiftlint lint --strict --quiet
      """

    try execute(bash: "echo '\(preCommitContents)' > .git/hooks/pre-commit")
}

/// Installs all dependencies with the exact versions specified on last update.
public func unregister() throws {
    try execute(bash: "rm -rf .git/hooks")
}

// MARK: - Helpers
private func execute(bash command: String) throws {
    print("⏳ Executing '\(command.italic.lightYellow)'".bold)
    try runAndPrint(bash: command)
}
