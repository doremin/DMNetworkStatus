// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DMNetworkStatus",
    platforms: [
        .iOS(.v12), .macOS(.v10_14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DMNetworkStatus",
            targets: ["DMNetworkStatus"]),
    ],
    dependencies: [
         .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.2.0"),
    ],
    targets: [
        .target(
            name: "DMNetworkStatus",
            dependencies: ["RxSwift"]),
    ]
)
