// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SalesforceMobileInterfaces",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SalesforceNetwork",
            targets: ["SalesforceNetwork"]
        ),
        .library(
            name: "SalesforceLogging",
            targets: ["SalesforceLogging"]
        ),
        .library(
            name: "SalesforceUser",
            targets: ["SalesforceUser"]
        ),
        .library(
            name: "SalesforceNavigation",
            targets: ["SalesforceNavigation"]
        ),
        .library(
            name: "SalesforceCache",
            targets: ["SalesforceCache"]
        )
    ],
    dependencies: [
        // Dependencies go here
    ],
    targets: [
        .target(
            name: "SalesforceNetwork",
            dependencies: []
        ),
        .target(
            name: "SalesforceLogging",
            dependencies: []
        ),
        .target(
            name: "SalesforceUser",
            dependencies: []
        ),
        .target(
            name: "SalesforceNavigation",
            dependencies: []
        ),
        .target(
            name: "SalesforceCache",
            dependencies: []
        ),
        .testTarget(
            name: "SalesforceNetworkTests",
            dependencies: ["SalesforceNetwork"]
        ),
        .testTarget(
            name: "SalesforceLoggingTests",
            dependencies: ["SalesforceLogging"]
        ),
        .testTarget(
            name: "SalesforceUserTests",
            dependencies: ["SalesforceUser"]
        ),
        .testTarget(
            name: "SalesforceNavigationTests",
            dependencies: ["SalesforceNavigation"]
        ),
        .testTarget(
            name: "SalesforceCacheTests",
            dependencies: ["SalesforceCache"]
        )
    ],
    swiftLanguageVersions: [.v5]
) 
