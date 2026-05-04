// swift-tools-version: 6.3.1

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
        ),
        .library(
            name: "Algebra Linear Primitives Test Support",
            targets: ["Algebra Linear Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-dimension-primitives"),
        .package(path: "../swift-format-primitives"),
        .package(path: "../swift-numeric-primitives"),
        .package(path: "../swift-tagged-primitives")
    ],
    targets: [
        .target(
            name: "Algebra Linear Primitives",
            dependencies: [
                .product(name: "Dimension Primitives", package: "swift-dimension-primitives"),
                .product(name: "Format Primitives", package: "swift-format-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives")
            ]
        ),
        .target(
            name: "Algebra Linear Primitives Test Support",
            dependencies: [
                "Algebra Linear Primitives",
                .product(name: "Tagged Primitives Test Support", package: "swift-tagged-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Algebra Linear Primitives Tests",
            dependencies: [
                "Algebra Linear Primitives",
                .product(name: "Tagged Primitives Standard Library Integration", package: "swift-tagged-primitives"),
                "Algebra Linear Primitives Test Support",
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
