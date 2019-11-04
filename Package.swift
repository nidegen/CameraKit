// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "CameraKit",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CameraKit",
            targets: ["CameraKit"]),
    ],
    targets: [
        .target(
            name: "CameraKit",
            dependencies: [],
            path: "Source"),
    ]
)
