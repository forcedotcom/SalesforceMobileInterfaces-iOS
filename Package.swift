// swift-tools-version:5.9
import PackageDescription

// SMI is distributed to SPM consumers as prebuilt XCFrameworks that are
// built with BUILD_LIBRARY_FOR_DISTRIBUTION=YES. This matches the resilient
// ABI expected by prebuilt consumers (MobileCustomizationFramework, the
// Agentforce SDK), and guarantees that the delivered framework is named
// exactly `<Module>.framework` so `@rpath/<Module>.framework` lookups
// resolve at runtime.
//
// Contract: framework name == product name == module name == target name.

let smiVersion = "1.1.0"
let releaseBase =
    "https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS/releases/download/\(smiVersion)"

let package = Package(
    name: "SalesforceMobileInterfaces",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "SalesforceNetwork", targets: ["SalesforceNetwork"]),
        .library(name: "SalesforceLogging", targets: ["SalesforceLogging"]),
        .library(name: "SalesforceUser", targets: ["SalesforceUser"]),
        .library(name: "SalesforceNavigation", targets: ["SalesforceNavigation"]),
        .library(name: "SalesforceCache", targets: ["SalesforceCache"]),
    ],
    targets: [
        .binaryTarget(
            name: "SalesforceNetwork",
            url: "\(releaseBase)/SalesforceNetwork.xcframework.zip",
            checksum: "f815c02a8106b2cda4d4599eafb484d7c4873f17c573991558876dfcfc34de50"
        ),
        .binaryTarget(
            name: "SalesforceLogging",
            url: "\(releaseBase)/SalesforceLogging.xcframework.zip",
            checksum: "51472af454df50f3f6ed6130606e61103eea28318337a8c8e0935650d1692d66"
        ),
        .binaryTarget(
            name: "SalesforceUser",
            url: "\(releaseBase)/SalesforceUser.xcframework.zip",
            checksum: "d6bc81a2c8d543004f4f3c90ddcff368da292630d8187ee02cd65ba20b1a0926"
        ),
        .binaryTarget(
            name: "SalesforceNavigation",
            url: "\(releaseBase)/SalesforceNavigation.xcframework.zip",
            checksum: "3cf225b705cb37d8c8f4625cc3690cf3ed6aae6655fab2dbf63df39b06bba58a"
        ),
        .binaryTarget(
            name: "SalesforceCache",
            url: "\(releaseBase)/SalesforceCache.xcframework.zip",
            checksum: "28327b1fe84bc65462ae102b72de37f2b9dee6e32d9044a8237635cc481f6d62"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
