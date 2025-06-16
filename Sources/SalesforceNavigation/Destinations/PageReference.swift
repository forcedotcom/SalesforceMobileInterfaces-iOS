//
//  PageReference.swift
//  MobileExtensionSDK
//
//  Created by Arnold Goldberg on 4/14/21.
//  Copyright © 2021 Salesforce. All rights reserved.
//

import Foundation

/// A Page Reference Destination
/// This destination represents a page reference event
/// https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/components_navigation_page_definitions.htm
/// This can be used by the consuming app to request a plugin to handle
/// Or for the plugin to navigate to a page reference
public struct PageReferenceDestination : Destination {
    public var original: Destination?
    
    public private(set) var pageReference: PageReference
    
    public init(type: String, attributes: [String: Any], state: [String: Any]?, original: Destination? = nil) {
        self.pageReference = PageReference(type: type, attributes: attributes, state: state)
        self.original = original
    }
}

public enum PageReferenceKeys: String {
    case PageType = "type"
    case Attributes = "attributes"
    case State = "state"
    case RecordId = "recordId"
    case ObjectAPIName = "objectApiName"
    case URL = "url"
    case ActionName = "actionName"
}

public enum PageReferenceTypes: String {
    case Record = "standard__recordPage"
    case Object = "standard__objectPage"
    case WebPage = "standard__webPage"
}

public enum PageReferenceValues: String {
    case Home = "home"
    case View = "view"
}

public struct PageReference {
    public let type: String
    public let attributes: [String: Any]
    public let state: [String: Any]?
    
    public init(type: String, attributes: [String: Any], state: [String: Any]? = nil) {
        self.type = type
        self.attributes = attributes
        self.state = state
    }
}
