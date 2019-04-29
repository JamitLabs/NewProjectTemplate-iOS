#!/usr/bin/env beak run --path

// MARK: - Script Dependencies
// beak: kareman/SwiftShell @ .upToNextMajor(from: "4.1.2")
// beak: onevcat/Rainbow @ .upToNextMajor(from: "3.1.2")

import Foundation
import Rainbow
import SwiftShell
import PackageConfig

// MARK: - Runnable Tasks
/// Registers git hooks for the project to ensure you get notified of potential issues e.g. before committing.
public func register() throws {
    try execute(bash: "mkdir -p .git/hooks")

    let preCommitContents: String = """
      #!/bin/bash
      bartycrouch lint --fail-on-warnings
      swiftlint lint --strict --quiet
      """

    try execute(bash: "echo '\(preCommitContents)' > .git/hooks/pre-commit")
}

/// Unregisters any registered git hooks.
public func unregister() throws {
    try execute(bash: "rm -rf .git/hooks")
}

// MARK: - Helpers
private func execute(bash command: String) throws {
    print("⏳ Executing '\(command.italic.lightYellow)'".bold)
    try runAndPrint(bash: command)
}
