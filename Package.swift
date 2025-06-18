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
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Infomaniak/ios-core-ui", .upToNextMajor(from: "19.0.0")),
        .package(url: "https://github.com/Infomaniak/ios-core", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/Infomaniak/ios-dependency-injection", .upToNextMajor(from: "2.0.3"))
    ],
    targets: [
        .target(
            name: "MyKSuite",
            dependencies: [
                .product(name: "InfomaniakDI", package: "ios-dependency-injection"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "DesignSystem", package: "ios-core-ui")
            ]
        ),
        .testTarget(name: "MyKSuiteTests", dependencies: ["MyKSuite"])
    ]
)
