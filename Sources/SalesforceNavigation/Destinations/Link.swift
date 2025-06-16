//
//  Link.swift
//  MobileExtensionSDK
//
//  Created by Joao Neves on 6/7/19.
//

import Foundation

/// Link represent only Salesforce endpoints
/// Org information can be provided via the org property
/// or inferred from the url itself
public struct Link: Destination {
    /// The entire URL that is being navigated to
    public let url: URL

    /// @see Destination
    public let original: Destination?
    
    public internal(set) var pageReference: PageReference

    public init(_ url: URL, original: Destination? = nil) {
        self.url = url
        self.original = original
        self.pageReference = PageReference(type: PageReferenceTypes.WebPage.rawValue, attributes: [PageReferenceKeys.URL.rawValue: url.absoluteString])
    }
    
    public init(_ url: URL, attributes: [String: Any], state: [String: Any]?, original: Destination? = nil) {
        self.init(url, original: original)
        self.pageReference = PageReference(type: PageReferenceTypes.WebPage.rawValue, attributes: attributes, state: state)
    }
}
