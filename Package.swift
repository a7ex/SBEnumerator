// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "sbenumerator",
    platforms: [
        .macOS(.v11),
    ],
    products: [
        .executable(
            name: "sbenumerator",
            targets: ["CommandlineTool"]
        ),
        .library(
            name: "SBEnumeratorLib",
            targets: ["SBEnumeratorLib"]
        )
    ],
    dependencies: [
        .package(
            name: "swift-argument-parser",
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMajor(from: "1.3.0")
        )
    ],
    targets: [
        .executableTarget(
            name: "CommandlineTool",
            dependencies: ["SBEnumeratorLib"],
            path: "CommandlineTool"
        ),
        .target(
            name: "SBEnumeratorLib",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                )
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "SBEnumeratorTests",
            dependencies: ["SBEnumeratorLib"]
        )
    ]
)
