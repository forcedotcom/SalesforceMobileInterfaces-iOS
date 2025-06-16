//
//  ObjectHome.swift
//  MobileExtensionSDK
//
//  Created by Kai Chen on 10/2/19.
//

import Foundation

// The ObjectHome represents a object page destination
public struct ObjectHome: Destination {
    /// The API name of the Entity
    public let type: String

    /// @see Destination
    public var original: Destination?

    public internal(set) var pageReference: PageReference

    public init(type: String, original: Destination? = nil) {
        self.type = type
        self.original = original
        self.pageReference = PageReference(type: PageReferenceTypes.Object.rawValue, attributes: [PageReferenceKeys.ObjectAPIName.rawValue: type, PageReferenceKeys.ActionName.rawValue: PageReferenceValues.Home.rawValue])
    }
    
    public init(type: String, attributes: [String: Any], state: [String: Any]?, original: Destination? = nil) {
        self.init(type: type, original: original)
        self.pageReference = PageReference(type: PageReferenceTypes.Object.rawValue, attributes: attributes, state: state)
    }
}
