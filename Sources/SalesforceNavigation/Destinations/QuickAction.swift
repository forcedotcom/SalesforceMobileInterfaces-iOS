//
//  QuickAction.swift
//  MobileExtensionSDK
//
//  Created by Kai Chen on 10/15/19.
//

import Foundation

/// QuickAction represents one of the server-defined actions
/// on an Entity, or a generic global action.
public struct QuickAction: Destination {

    /// The API name of the QuickAction
    public let actionName: String
    
    /// Parameters to be used with the action
    public let attributes: [String: Any]

    /// Context for the quick action if needed.
    /// Each QuickAction can handle this differently
    /// ### Example
    /// - A feed post will be made on this record's feed
    /// - A new task will be added to a specific record
    public let target: Record?

    /// @see Destination
    public var original: Destination?
    
    public init(actionName: String,
                attributes: [String: Any] = [:],
                target: Record? = nil,
                original: Destination? = nil) {
        self.actionName = actionName
        self.attributes = attributes
        self.target = target
        self.original = original
    }
}