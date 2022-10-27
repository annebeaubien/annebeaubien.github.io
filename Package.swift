// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "WaffleHearts",
    platforms: [.macOS(.v12)],
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
