// swift-tools-version:5.9

import PackageDescription
 
let package = Package(
    name: "MvvmFoundation",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MvvmFoundation",
            targets: ["MvvmFoundation"]),
    ],
    targets: [
        .target(
            name: "MvvmFoundation"
        )
    ]
)
