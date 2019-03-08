// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "NewProjectTemplate",
    products: [],
    dependencies: [
        // Handy Swift features that didn't make it into the Swift standard library.
        .package(url: "https://github.com/Flinesoft/HandySwift.git", .upToNextMajor(from: "2.8.0")),

        // Handy UI features that should have been part of UIKit in the first place.
        .package(url: "https://github.com/Flinesoft/HandyUIKit.git", .upToNextMajor(from: "1.9.1")),

        // Keep the screen flow and data handling logic out of your view controllers – let them handle view-stuff only.
        .package(url: "https://github.com/Flinesoft/Imperio.git", .upToNextMajor(from: "3.0.2")),

        // Error Handler based on localized & healable (recoverable) errors without the overhead of NSError.
        .package(url: "https://github.com/JamitLabs/MungoHealer.git", .upToNextMajor(from: "0.3.2")),

        // Convenient logging during development & release in Swift
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "1.6.2")),

        // Modern Swift API for NSUserDefaults
        .package(url: "https://github.com/radex/SwiftyUserDefaults.git", .upToNextMajor(from: "4.0.0-beta.1")),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "HandySwift",
                "HandyUIKit",
                "Imperio",
                "MungoHealer",
                "SwiftyBeaver",
                "SwiftyUserDefaults",
            ]
        ),
    ]
)
