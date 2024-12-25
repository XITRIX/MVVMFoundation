// swift-tools-version:6.0

import PackageDescription
 
let package = Package(
    name: "MvvmFoundation",
    platforms: [.iOS(.v13), .tvOS(.v14)],
    products: [
        .library(
            name: "MvvmFoundation",
            targets: ["MvvmFoundation"]),
    ],
    targets: [
        .target(
            name: "MvvmFoundation"
//            swiftSettings: [
//                .enableUpcomingFeature("StrictConcurrency")
//            ]
        )
    ]
)
