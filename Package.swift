// swift-tools-version: 6.0
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
        .package(url: "https://github.com/Infomaniak/ios-core-ui", .upToNextMajor(from: "18.0.0"))
    ],
    targets: [
        .target(
            name: "MyKSuite",
            dependencies: [
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "DesignSystem", package: "ios-core-ui")
            ]
        )
    ]
)
