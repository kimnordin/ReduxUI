// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReduxUI",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ReduxUI",
            targets: ["ReduxUI"]),
    ],
    targets: [
        .target(
            name: "ReduxUI",
            dependencies: []),
        .testTarget(
            name: "ReduxUITests",
            dependencies: ["ReduxUI"]),
    ]
)
