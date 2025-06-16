//
//  Community.swift
//  MobileExtensionSDK
//
//  Created by Joao Neves on 6/10/19.
//

import Foundation

/// Represents a Salesforce Experience Cloud community
///
/// This struct encapsulates the identity of a Salesforce community
/// (also known as an Experience Cloud site) and is used to provide
/// community context for operations that may behave differently
/// within a community versus a standard Salesforce org.
public struct Community {
    /// The unique identifier of the community
    ///
    /// This is always an 18-character alphanumeric string that uniquely
    /// identifies the community within the Salesforce organization.
    /// This ID is used in API calls, URL construction, and for access control.
    public let id: String

    /// Creates a new Community instance with the specified ID
    ///
    /// - Parameter id: The unique 18-character identifier of the community
    public init(id: String) {
        self.id = id
    }
}
