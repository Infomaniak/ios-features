// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-features",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "AppLock",
            targets: ["AppLock"]
        ),
        .library(
            name: "ContactCard",
            targets: ["ContactCard"]
        ),
        .library(
            name: "InAppTwoFactorAuthentication",
            targets: ["InAppTwoFactorAuthentication"]
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
        ),
        .library(
            name: "MyKSuite",
            targets: ["MyKSuite"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Infomaniak/ios-core", .upToNextMajor(from: "19.0.0")),
        .package(url: "https://github.com/Infomaniak/ios-core-ui", .upToNextMajor(from: "26.0.0")),
        .package(url: "https://github.com/Infomaniak/ios-dependency-injection", .upToNextMajor(from: "2.0.3")),
        .package(url: "https://github.com/Infomaniak/ios-device-check", .upToNextMajor(from: "1.1.1")),
        .package(url: "https://github.com/Infomaniak/ios-login", .upToNextMajor(from: "7.8.0")),
        .package(url: "https://github.com/kean/Nuke", .upToNextMajor(from: "12.1.3")),
        .package(url: "https://github.com/dagronf/QRCode", .upToNextMajor(from: "16.0.0"))
    ],
    targets: [
        .target(
            name: "AppLock",
            dependencies: [
                .product(name: "InfomaniakDI", package: "ios-dependency-injection"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "InfomaniakCoreCommonUI", package: "ios-core-ui"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "DesignSystem", package: "ios-core-ui")
            ]
        ),
        .target(
            name: "ContactCard",
            dependencies: [
                .product(name: "InfomaniakDI", package: "ios-dependency-injection"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "InfomaniakCoreCommonUI", package: "ios-core-ui"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "DesignSystem", package: "ios-core-ui"),
                .product(name: "QRCode", package: "QRCode"),
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke")
            ]
        ),
        .target(
            name: "InAppTwoFactorAuthentication",
            dependencies: [
                .product(name: "InfomaniakDI", package: "ios-dependency-injection"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "DeviceAssociation", package: "ios-core"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "DesignSystem", package: "ios-core-ui"),
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke")
            ]
        ),
        .target(
            name: "InterAppLogin",
            dependencies: [
                .product(name: "DesignSystem", package: "ios-core-ui"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "InfomaniakCoreUIResources", package: "ios-core-ui"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "InfomaniakDeviceCheck", package: "ios-device-check"),
                .product(name: "InfomaniakDI", package: "ios-dependency-injection"),
                .product(name: "InfomaniakLogin", package: "ios-login"),
                .product(name: "NukeUI", package: "Nuke"),
                .product(name: "Nuke", package: "Nuke")
            ]
        ),
        .target(
            name: "KSuite",
            dependencies: [
                "KSuiteUtils",
                .product(name: "DesignSystem", package: "ios-core-ui"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "InfomaniakCoreUIResources", package: "ios-core-ui")
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
            name: "MyKSuite",
            dependencies: [
                "KSuiteUtils",
                .product(name: "InfomaniakDI", package: "ios-dependency-injection"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "InfomaniakCoreSwiftUI", package: "ios-core-ui"),
                .product(name: "DesignSystem", package: "ios-core-ui")
            ]
        ),
        .testTarget(name: "MyKSuiteTests", dependencies: ["MyKSuite"]),
        .testTarget(name: "ContactCardTests", dependencies: ["ContactCard"])
    ]
)
