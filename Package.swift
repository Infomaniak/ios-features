// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-features",
    products: [
        .library(
            name: "ios-features",
            targets: ["ios-features"]
        ),
    ],
    targets: [
        .target(
            name: "ios-features"
        )
    ]
)
