// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "icecubesweb",
    platforms: [.macOS(.v13)],
    dependencies: [
      .package(url: "https://github.com/swift-cloud/VercelUI", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "icecubesweb",
            dependencies: ["VercelUI"], 
            path: "Sources"),
    ]
)
