//
//  Network.swift
//  MobileExtensionSDK
//
//  Created by Alex Sikora on 4/16/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import Foundation

/// This is the primary networking protocol for consuming applications to implement and pass in to SPI implementations.
/// Network allows plugins to utilize the networking library of the consuming application to perform network requests
/// within the current context (e.g. current user / authenticated requests).
///
/// Implementations of this protocol should handle:
/// - Authentication token management
/// - Request retries and error handling
/// - Proper response parsing
/// - Network availability monitoring
///
/// All network operations are performed asynchronously using Swift's structured concurrency.
public protocol Network {
    /// Sends a network request through the host application and returns the resulting data
    ///
    /// - Parameters:
    ///   - request: The network request containing URL, headers, body, and authentication requirements
    /// - Returns:
    ///   - A tuple containing the response data and URL response metadata
    /// - Throws:
    ///   - Network errors including connection failures, timeouts, and server errors
    ///   - Authentication errors if the request requires authentication and it fails
    ///   - Any other implementation-specific errors
    func data(for request: NetworkRequest) async throws -> (Data, URLResponse)
}