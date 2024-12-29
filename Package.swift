// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "WaffleHearts",
    platforms: [.macOS(.v15)],
    products: [
        .executable(
            name: "WaffleHearts",
            targets: ["WaffleHearts"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.9.0"),
        .package(name: "CNAMEPublishPlugin", url: "https://github.com/SwiftyGuerrero/CNAMEPublishPlugin", .branch("master")),
    ],
    targets: [
        .executableTarget(
            name: "WaffleHearts",
            dependencies: [
                "Publish",
                "CNAMEPublishPlugin",
            ]
        )
    ]
)
