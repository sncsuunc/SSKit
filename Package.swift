// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSKit",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "SSKit",
            targets: [
                "SSKit"
            ]),
        .library(
            name: "SSKitCores",
            targets: [
                "SSKitCores"
            ]),
        .library(
            name: "SSKitViews",
            targets: [
                "SSKitViews"
            ]),
        .library(
            name: "SSKitRouters",
            targets: [
                "SSKitRouters"
            ])
        
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "SSKit",
                dependencies: [
                    "SSKitCores",
                    "SSKitViews",
                    "SSKitRouters"
                ]),
        .target(name: "SSKitCores",
                dependencies: [
                ]),
        .target(name: "SSKitViews",
                dependencies: [
                    "SSKitCores"
                ]),
        .target(name: "SSKitRouters",
                dependencies: [
                    "SSKitCores"
                ])
    ]
)
