//
//  Org.swift
//  MobileExtensionSDK
//
//  Created by Joao Neves on 6/7/19.
//

import Foundation

/// Represents a Salesforce organization
///
/// This struct encapsulates information about a Salesforce org,
/// including its unique identifier and optional community context.
/// It is used to provide organizational context for user operations
/// and API requests.
public struct Org {
    /// The unique identifier of the Salesforce organization
    ///
    /// This is always an 18-character alphanumeric string that uniquely
    /// identifies the organization across all Salesforce instances.
    public let id: String

    /// The optional community context for this organization
    ///
    /// When a user is operating within a Salesforce Experience Cloud community,
    /// this property contains information about that community.
    /// This affects URL construction, API endpoints, and context for operations.
    public let community: Community?

    /// Creates a new Org instance with the specified attributes
    ///
    /// - Parameters:
    ///   - id: The unique 18-character identifier of the organization
    ///   - community: Optional community context if the user is operating within a community
    public init(id: String, community: Community? = nil) {
        self.id = id
        self.community = community
    }
}
