// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "EVPlayer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "EVPlayer",
            targets: ["EVPlayer"]
        )
    ],
    targets: [
        .target(
            name: "EVPlayer",
            path: "Source",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
