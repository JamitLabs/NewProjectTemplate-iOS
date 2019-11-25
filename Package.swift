// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "NewProjectTemplate",
    products: [],
    dependencies: [
        // Keep the screen flow and data handling logic out of your view controllers – let them handle view-stuff only.
        .package(url: "https://github.com/Flinesoft/Imperio.git", .upToNextMajor(from: "3.0.2")),

        // Convenient logging during development & release in Swift
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "1.8.2")),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "Imperio",
                "SwiftyBeaver",
            ],
            path: "App"
        ),
        .testTarget(
            name: "Tests",
            dependencies: [
            ],
            path: "Tests"
        ),
    ]
)
