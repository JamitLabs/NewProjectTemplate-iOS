#!/usr/bin/env beak run --path

// MARK: - Script Dependencies
// beak: kareman/SwiftShell @ .upToNextMajor(from: "4.1.2")
// beak: onevcat/Rainbow @ .upToNextMajor(from: "3.1.2")

import Foundation
import Rainbow
import SwiftShell

// MARK: - Runnable Tasks
/// Lints the project with all configured linters like it would on the CI.
public func lint() throws {
    for lintStep in Constants.lintSteps {
        print("⏳ Linting with \(lintStep.name.lightGreen) ...".bold)
        let output = run(bash: lintStep.command)

        if output.succeeded {
            print("✅ \(lintStep.name) linted successfully. No issues found.")
        } else {
            print(output.stdout)
            print("❌ \(lintStep.name) linting failed. See above output for details.")
        }
    }
}

// MARK: - Helpers
private func lint(bash command: String) -> RunOutput {

    return run(bash: command)
}

private func findXcodeProject() -> String {
    let xcodeWorkspaces = run(bash: "find . -d 1 -regex '.*\\.xcworkspace' -type d").stdout.components(separatedBy: .newlines).filter { !$0.isEmpty }
    let xcodeProjects = run(bash: "find . -d 1 -regex '.*\\.xcodeproj' -type d").stdout.components(separatedBy: .newlines).filter { !$0.isEmpty }

    if let workspacePath = xcodeWorkspaces.first {
        return workspacePath
    } else if let projectPath = xcodeProjects.first {
        return projectPath
    } else {
        fatalError("Could not find an Xcode project in current directory.")
    }
}

struct LintStep {
    let name: String
    let command: String
}

enum Constants {
    static let lintSteps: [LintStep] = [
        LintStep(name: "BartyCrouch", command: "bartycrouch lint -w"),
        LintStep(name: "SwiftLint", command: "swiftlint"),
        LintStep(name: "ProjLint", command: "projlint lint"),
        LintStep(
            name: "Periphery",
            command: """
                periphery scan \\
                --project \(findXcodeProject())/ \\
                --schemes App \\
                --targets App,Tests,UITests \\
                --report-exclude 'App/Generated/SwiftGen/*.swift|App/SupportingFiles/*.swift' \\
                --no-retain-public
                """
        )
    ]
}
