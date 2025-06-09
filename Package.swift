// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CameraKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CameraKit",
            targets: ["CameraKit"]
        )
    ],
    targets: [
        .target(
            name: "CameraKit"
        ),
        .testTarget(
            name: "CameraKitTests",
            dependencies: ["CameraKit"]
        )
    ]
)
