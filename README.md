# SalesforceMobileInterfaces

A collection of Swift protocol interfaces designed for mobile plugins that integrate with Salesforce mobile applications. This library provides standardized interfaces for common mobile operations like networking, logging, navigation, user management, and caching.

## Overview

SalesforceMobileInterfaces serves as a bridge between Salesforce mobile applications and their plugins, providing a unified set of protocols that enable plugins to access host application capabilities while maintaining clean separation of concerns.

## Features

- **🌐 Network Interface**: Standardized networking with authentication and context awareness
- **📝 Logging Interface**: Structured logging with configurable severity levels
- **👤 User Management**: User, organization, and community data models
- **🧭 Navigation Interface**: Navigate to Salesforce records, objects, and URLs
- **💾 Cache Interface**: Async data caching with user-scoped operations

## Requirements

- iOS 16.0+
- Swift 5.9+
- Xcode 14.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS.git", from: "1.0.0")
]
```

Then specify the individual modules you need in your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "SalesforceNetwork", package: "SalesforceMobileInterfaces"),
        .product(name: "SalesforceLogging", package: "SalesforceMobileInterfaces"),
        // Add other modules as needed
    ]
)
```

### CocoaPods

Add the specific podspecs you need to your `Podfile`:

```ruby
pod 'SalesforceNetwork'
pod 'SalesforceLogging'
pod 'SalesforceUser'
pod 'SalesforceNavigation'
pod 'SalesforceCache'
```

## Modules

### SalesforceNetwork
Provides networking capabilities with built-in authentication and context management.

```swift
import SalesforceNetwork

// Implement the Network protocol in your host application
class MyNetworkService: Network {
    func data(for request: NetworkRequest) async throws -> (Data, URLResponse) {
        // Implementation with authentication, retries, etc.
    }
}
```

### SalesforceLogging
Structured logging interface with severity levels.

```swift
import SalesforceLogging

// Implement logging in your host application
class MyLogger: Logger {
    func log(_ logMessage: String, level: LogLevel) {
        switch level {
        case .error: print("ERROR: \(logMessage)")
        case .warning: print("WARNING: \(logMessage)")
        case .info: print("INFO: \(logMessage)")
        case .debug: print("DEBUG: \(logMessage)")
        }
    }
}
```

### SalesforceUser
Data models for Salesforce users, organizations, and communities.

```swift
import SalesforceUser

let user = User(
    userId: "005XXXXXXXXXXXXXXXXX",
    org: myOrg,
    username: "user@example.com",
    displayName: "John Doe",
    firstName: "John",
    avatarURL: URL(string: "https://example.com/avatar.jpg")
)
```

### SalesforceNavigation
Navigation interface for moving between Salesforce destinations.

```swift
import SalesforceNavigation

// Implement navigation in your host application
class MyNavigationService: Navigation {
    func go(to destination: Destination) {
        // Navigate to records, object homes, URLs, etc.
    }
    
    func go(to destination: Destination, replace: Bool) {
        // Navigate with replacement control
    }
}
```

### SalesforceCache
Async caching interface for user-scoped data storage.

```swift
import SalesforceCache

// Implement caching in your host application
class MyCacheService: Cache {
    func save(_ data: Data, key: String) async throws {
        // Save data to cache
    }
    
    func load(_ key: String) async throws -> Data? {
        // Load data from cache
    }
    
    func remove(_ key: String) async throws {
        // Remove specific cache entry
    }
    
    func removeAll() async throws {
        // Clear all cache data
    }
}
```

## Usage

These interfaces are designed to be implemented by host applications and passed to plugins. Here's a typical integration pattern:

```swift
// In your host application
let networkService = MyNetworkService()
let logger = MyLogger()
let navigation = MyNavigationService()
let cache = MyCacheService()

// Pass to your plugin
let plugin = SomePlugin(
    network: networkService,
    logger: logger,
    navigation: navigation,
    cache: cache
)
```

## Development

### Building the Project

```bash
swift build
```

### Running Tests

```bash
swift test
```

### Generating Documentation

```bash
swift package generate-documentation
```

## Contributing

Please read our contribution guidelines and ensure all tests pass before submitting pull requests.

## License

Copyright (c) 2011-present, salesforce.com, inc. All rights reserved.

See [LICENSE.txt](LICENSE.txt) for full license terms.
