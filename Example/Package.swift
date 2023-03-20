// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "EVPlayer",
    platforms: [.iOS(.v12+)],
    products: [
        .library(
            name: "EVPlayer",
            targets: ["EVPlayer"])
    ],
    targets: [
        .target(
            name: "EVPlayer",
            path: "Source")
    ]
)
