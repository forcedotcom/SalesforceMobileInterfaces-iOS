//
//  Record.swift
//  MobileExtensionSDK
//
//  Created by Joao Neves on 6/7/19.
//

import Foundation

public struct Record: Destination {
    /// The entity ID of the record. 18 characters
    public let id: String
    /// Optionally the API Name of the record if it is known
    public let type: String?
    /// @see Destination
    public let original: Destination?

    public internal(set) var pageReference: PageReference

    public init(id: String, type: String? = nil, original: Destination? = nil) {
        self.id = id
        self.type = type
        self.original = original
        
        var attributes = [PageReferenceKeys.RecordId.rawValue: id,
                          PageReferenceKeys.ActionName.rawValue: PageReferenceValues.View.rawValue]
        if let objectAPIName = type {
            attributes[PageReferenceKeys.ObjectAPIName.rawValue] = objectAPIName
        }
        self.pageReference = PageReference(type: PageReferenceTypes.Record.rawValue, attributes: attributes)
        
    }
    
    public init(id: String, type: String? = nil, attributes: [String: Any], state: [String: Any]?, original: Destination? = nil) {
        self.init(id: id, type: type, original: original)
        self.pageReference = PageReference(type: PageReferenceTypes.Record.rawValue, attributes: attributes, state: state)
    }
}
