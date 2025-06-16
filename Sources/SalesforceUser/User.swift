//
//  User.swift
//  MobileExtensionSDK
//
//  Created by Alex Sikora on 10/14/19.
//

import Foundation

/// A representation of a Salesforce user
///
/// This struct encapsulates the essential information about a Salesforce user,
/// including their identity, organization, and display information.
/// It is used throughout the SDK to represent the current authenticated user
/// and to provide context for operations that require user information.
public struct User {
    /// The unique identifier of the user in Salesforce
    ///
    /// This 18-character ID uniquely identifies the user across all Salesforce instances
    /// and is used for API calls, data access, and permissions checks.
    public let userId: String

    /// The organization that the user belongs to
    ///
    /// Contains information about the Salesforce org including its ID
    /// and optionally, community context if the user is operating within a community.
    public let org: Org

    /// The user's Salesforce username (typically an email address)
    ///
    /// This is the username the user uses to log into Salesforce
    /// and is unique across all Salesforce instances.
    public let username: String

    /// The user's full name formatted for display in the UI
    ///
    /// This should be used when showing the user's name in the interface
    /// and may include prefixes, suffixes, or other formatting.
    public let displayName: String

    /// The user's first name
    ///
    /// Optional field that may be used for more personalized UI experiences.
    public let firstName: String?

    /// The URL to the user's profile picture
    ///
    /// Optional field that can be used to display the user's avatar in the UI.
    /// If nil, implementations should fall back to default avatar imagery.
    public let avatarURL: URL?

    /// Creates a new User instance with the specified attributes
    ///
    /// - Parameters:
    ///   - userId: The unique identifier of the user
    ///   - org: The organization the user belongs to
    ///   - username: The user's Salesforce username
    ///   - displayName: The user's name formatted for display
    ///   - firstName: Optional first name of the user
    ///   - avatarURL: Optional URL to the user's profile picture
    public init(userId: String, org: Org, username: String, displayName: String, firstName: String? = nil, avatarURL: URL? = nil) {
        self.userId = userId
        self.org = org
        self.username = username
        self.displayName = displayName
        self.firstName = firstName
        self.avatarURL = avatarURL
    }
}
