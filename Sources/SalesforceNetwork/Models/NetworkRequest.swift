//
//  NetworkRequest.swift
//  MobileExtensionSDK
//
//  Created by Alex Sikora on 4/16/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import Foundation

/// NetworkRequest encapsulates all the necessary information for making network requests
/// to Salesforce authenticated endpoints and other third-party services.
///
/// This struct provides a unified way for plugins to make network requests through the host
/// application, which handles authentication, headers, and other networking details.
public struct NetworkRequest {
    /// The base URLRequest that defines the core properties of the network request
    ///
    /// This includes:
    /// - URL (endpoint path for Salesforce APIs or full URL for external services)
    /// - HTTP method (GET, POST, PUT, DELETE, etc.)
    /// - HTTP headers (Content-Type, Accept, etc.)
    /// - Body data for POST/PUT requests
    /// - Timeout configurations
    ///
    /// For Salesforce API requests, you typically don't need to specify the full domain
    /// in the URL, as the host application will append the appropriate instance URL.
    public var baseRequest: URLRequest
    
    /// Specifies whether the request requires authentication headers
    ///
    /// When set to true:
    /// - The host application will add appropriate authentication headers (OAuth tokens)
    /// - These headers will be added on top of any existing headers in baseRequest
    ///
    /// When set to false:
    /// - No authentication headers will be added
    /// - Use this when calling non-Salesforce endpoints that don't require Salesforce auth
    ///
    /// When set to nil:
    /// - The host application will use its default behavior
    /// - Typically true for requests to Salesforce domains
    public var requiresAuthentication: Bool?
    
    /// Specifies whether the request requires JWT token authentication
    ///
    /// When set to true:
    /// - The host application will add SFAP JWT authentication to the request
    /// - This is used for specific Salesforce APIs that require this authentication method
    ///
    /// When set to false or nil:
    /// - Standard authentication or no authentication will be used based on requiresAuthentication
    public var requiresSFAPAuthentication: Bool?

    /// Controls whether the request should automatically retry on HTTP 403 responses
    ///
    /// When set to true (default):
    /// - The host application will attempt to refresh the authentication token and retry the request
    /// - This helps handle expired tokens without requiring manual token refresh
    ///
    /// When set to false:
    /// - 403 responses will be returned as-is without retrying
    /// - Use this for requests where you want to handle 403 errors yourself
    public var shouldRefreshOn403 = true
    
    /// Creates a new NetworkRequest with the specified base request
    ///
    /// - Parameter baseRequest: The URLRequest to use as the foundation for this network request
    public init(baseRequest: URLRequest) {
        self.baseRequest = baseRequest
    }
}
