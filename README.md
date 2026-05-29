# Linear Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Linear algebra primitives — composes dimension, format, and numeric primitives to express linear-algebraic structure.

## Installation

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-linear-primitives.git", from: "0.1.0")
]
```

Add the product to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Linear Primitives", package: "swift-linear-primitives")
    ]
)
```

Requires Swift 6.2+.

## License

Apache 2.0. See [LICENSE](LICENSE).
