import XCTest
@testable import SalesforceNavigation

final class DestinationTests: XCTestCase {
    
    // MARK: - Record Tests
    
    func testRecordDestination() {
        // Arrange
        let recordId = "001xx000003DGT2AAO"
        let objectType = "Account"
        
        // Act
        let record = Record(id: recordId, type: objectType)
        
        // Assert
        XCTAssertEqual(record.id, recordId)
        XCTAssertEqual(record.type, objectType)
        XCTAssertNil(record.original)
        
        // Test with original destination
        let originalDest = Link(URL(string: "https://salesforce.com")!)
        let recordWithOriginal = Record(id: recordId, type: objectType, original: originalDest)
        
        XCTAssertEqual(recordWithOriginal.id, recordId)
        XCTAssertEqual(recordWithOriginal.type, objectType)
        XCTAssertNotNil(recordWithOriginal.original)
        XCTAssertTrue(recordWithOriginal.original is Link)
    }
    
    // MARK: - ObjectHome Tests
    
    func testObjectHomeDestination() {
        // Arrange
        let objectType = "Contact"
        
        // Act
        let objectHome = ObjectHome(type: objectType)
        
        // Assert
        XCTAssertEqual(objectHome.type, objectType)
        XCTAssertNil(objectHome.original)
        
        // Test with original destination
        let originalDest = Link(URL(string: "https://salesforce.com")!)
        let objectHomeWithOriginal = ObjectHome(type: objectType, original: originalDest)
        
        XCTAssertEqual(objectHomeWithOriginal.type, objectType)
        XCTAssertNotNil(objectHomeWithOriginal.original)
        XCTAssertTrue(objectHomeWithOriginal.original is Link)
    }
    
    // MARK: - Link Tests
    
    func testLinkDestination() {
        // Arrange
        let url = URL(string: "https://salesforce.com")!
        
        // Act
        let link = Link(url)
        
        // Assert
        XCTAssertEqual(link.url, url)
        XCTAssertNil(link.original)
        
        // Test with original destination
        let originalDest = Record(id: "001xx000003DGT2AAO", type: "Account")
        let linkWithOriginal = Link( url, original: originalDest)
        
        XCTAssertEqual(linkWithOriginal.url, url)
        XCTAssertNotNil(linkWithOriginal.original)
        XCTAssertTrue(linkWithOriginal.original is Record)
    }
    
    // MARK: - PageReference Tests
    
    func testPageReferenceDestination() {
        // Arrange
        let pageType = "standard__recordPage"
        let attributes = [
            "recordId": "001xx000003DGT2AAO",
            "objectApiName": "Account",
            "actionName": "view"
        ]
        
        // Act
        let pageReference = PageReferenceDestination(type: pageType, attributes: attributes, state:nil)
        
        // Assert
        XCTAssertEqual(pageReference.pageReference.type, pageType)
        XCTAssertEqual(pageReference.pageReference.attributes.count, 3)
        XCTAssertEqual(pageReference.pageReference.attributes["recordId"] as? String, "001xx000003DGT2AAO")
        XCTAssertEqual(pageReference.pageReference.attributes["objectApiName"] as? String, "Account")
        XCTAssertEqual(pageReference.pageReference.attributes["actionName"] as? String, "view")
        XCTAssertNil(pageReference.original)
        
        // Test with original destination
        let originalDest = Link( URL(string: "https://salesforce.com")!)
        let pageRefWithOriginal = PageReferenceDestination(type: pageType, attributes: attributes, state: nil, original: originalDest)
        
        XCTAssertEqual(pageRefWithOriginal.pageReference.type, pageType)
        XCTAssertNotNil(pageRefWithOriginal.original)
        XCTAssertTrue(pageRefWithOriginal.original is Link)
    }
    
    // MARK: - QuickAction Tests
    
    func testQuickActionDestination() {
        // Arrange
        let actionName = "NewContact"
        let objectType = "Account"
        let recordId = "001xx000003DGT2AAO"
        
        // Act
        let quickAction = QuickAction(actionName: actionName)
        
        // Assert
        XCTAssertEqual(quickAction.actionName, actionName)
        XCTAssertNil(quickAction.original)
        
        // Test with original destination
        let originalDest = Link( URL(string: "https://salesforce.com")!)
        let targetRecord = Record(id: recordId, type: objectType)
        let quickActionWithOriginal = QuickAction(actionName: actionName, target: targetRecord, original: originalDest)
        
        XCTAssertEqual(quickActionWithOriginal.actionName, actionName)
        XCTAssertEqual(quickActionWithOriginal.target?.type, objectType)
        XCTAssertEqual(quickActionWithOriginal.target?.id, recordId)
        XCTAssertNotNil(quickActionWithOriginal.original)
        XCTAssertTrue(quickActionWithOriginal.original is Link)
    }
} 
