// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PickerKit",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
        .macOS(.v12),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "PickerKit",
            targets: ["PickerKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/danielsaidi/FontKit",
            .upToNextMajor(from: "0.1.4")
        )
    ],
    targets: [
        .target(
            name: "PickerKit",
            dependencies: ["FontKit"]
        ),
        .testTarget(
            name: "PickerKitTests",
            dependencies: ["PickerKit"]
        )
    ]
)
