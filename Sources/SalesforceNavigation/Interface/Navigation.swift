//
//  Navigation.swift
//  MobileExtensionSDK
//
//  Created by Joao Neves on 4/29/19.
//

import Foundation

/// Defines the navigation capabilities for the Salesforce mobile experience
///
/// This protocol allows plugins to navigate to different destinations within
/// the Salesforce mobile application, including records, object homes, URLs,
/// and Lightning page references. The host application is responsible for implementing
/// the actual navigation logic based on the provided destinations.
public protocol Navigation {
    /// Navigates to the specified destination
    ///
    /// This method navigates to the given destination, typically by pushing it onto
    /// the navigation stack or presenting it modally, depending on the host application's
    /// navigation patterns.
    ///
    /// - Parameter to: The destination to navigate to (e.g., a record, object home, URL)
    // swiftlint:disable identifier_name
    func go(to: Destination)
    // swiftlint:enable identifier_name

    /// Navigates to the specified destination with replacement control
    ///
    /// This method provides more control over the navigation behavior by allowing
    /// the caller to specify whether the current view should be replaced with the
    /// destination or if the destination should be added to the navigation stack.
    ///
    /// - Parameters:
    ///   - to: The destination to navigate to (e.g., a record, object home, URL)
    ///   - replace: When true, replaces the current view with the destination;
    ///              when false, adds the destination to the navigation stack
    // swiftlint:disable identifier_name
    func go(to: Destination, replace: Bool)
    // swiftlint:enable identifier_name
}
