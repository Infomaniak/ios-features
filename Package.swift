// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-features",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MyKSuite",
            targets: ["MyKSuite"]
        ),
        .library(
            name: "InterAppLogin",
            targets: ["InterAppLogin"]
        ),
        .library(
            name: "KSuite",
            targets: ["KSuite"]
        ),
        .library(
            name: "KSuiteUtils",
            targets: ["KSuiteUtils"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Infomaniak/ios-core-ui", .upToNextMajor(from: "22.0.0")),
        .package(url: "https://github.com/Infomaniak/ios-core", .upToNextMajor(from: "16.0.0")),
        .package(url: "https://github.com/Infomaniak/ios-dependency-injection", .upToNextMajor(from: "2.0.3")),
        .package(url: "https://github.com/kean/Nuke", .upToNextMajor(from: "12.1.3"))
    ],
    targets: [
        .target(
            name: "MyKSuite",
            dependencies: [
                "KSuiteUtils",
                .product(name: "InfomaniakDI", package: "ios-dependency-injection"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "DesignSystem", package: "ios-core-ui")
            ]
        ),
        .target(
            name: "KSuite",
            dependencies: [
                "KSuiteUtils",
                .product(name: "DesignSystem", package: "ios-core-ui"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui")
            ]
        ),
        .target(
            name: "KSuiteUtils",
            dependencies: [
                .product(name: "DesignSystem", package: "ios-core-ui"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui")
            ]
        ),
        .target(
            name: "InterAppLogin",
            dependencies: [
                .product(name: "InfomaniakDI", package: "ios-dependency-injection"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "DesignSystem", package: "ios-core-ui"),
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke")
            ]
        ),
        .testTarget(name: "MyKSuiteTests", dependencies: ["MyKSuite"])
    ]
)
