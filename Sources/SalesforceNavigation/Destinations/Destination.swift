//
//  Destination.swift
//  MobileExtensionSDK
//
//  Created by Joao Neves on 5/10/19.
//

import Foundation

/// The destination protocol represents anything that can be navigated to,
/// examples are: Salesforce Records, Links, Lightning pages, etc…
public protocol Destination {
    /// Used by a router when manipulating a destination
    /// Will be passed along to PluginNavigation to allow
    /// a plugin to parse additional data from a URL/Lightning
    /// in order to display specific data
    /// ### Example
    /// Display a specific comment on a feed item
    var original: Destination? { get }
}
