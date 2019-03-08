// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "NewProjectTemplate",
    products: [],
    dependencies: [
        // add your dependencies here, for example:
        // .package(url: "https://github.com/User/Project.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                // add your dependencies scheme names here, for example:
                // "Project",
            ]
        ),
    ]
)
