// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "WaffleHearts",
    products: [
        .executable(
            name: "WaffleHearts",
            targets: ["WaffleHearts"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "WaffleHearts",
            dependencies: ["Publish"]
        )
    ]
)