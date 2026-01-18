// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-algebra-linear-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Algebra Linear Primitives",
            targets: ["Algebra Linear Primitives"]
        )
    ],
    dependencies: [
        .package(path: "../swift-algebra-primitives"),
        .package(path: "../swift-dimension-primitives"),
        .package(path: "../swift-formatting-primitives"),
        .package(path: "../swift-numeric-primitives")
    ],
    targets: [
        .target(
            name: "Algebra Linear Primitives",
            dependencies: [
                .product(name: "Algebra Primitives", package: "swift-algebra-primitives"),
                .product(name: "Dimension Primitives", package: "swift-dimension-primitives"),
                .product(name: "Formatting Primitives", package: "swift-formatting-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableExperimentalFeature("Lifetimes"),
        .strictMemorySafety()
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
