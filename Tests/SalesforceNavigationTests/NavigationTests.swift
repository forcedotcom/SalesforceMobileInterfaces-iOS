import XCTest
@testable import SalesforceNavigation

final class NavigationTests: XCTestCase {
    
    // Mock implementation of Navigation protocol for testing
    private class MockNavigation: Navigation {
        var lastDestination: Destination?
        var lastReplaceValue: Bool?
        
        func go(to destination: Destination) {
            lastDestination = destination
            lastReplaceValue = nil
        }
        
        func go(to destination: Destination, replace: Bool) {
            lastDestination = destination
            lastReplaceValue = replace
        }
    }
    
    // Mock implementation of Destination protocol for testing
    private struct MockDestination: Destination {
        let original: Destination?
        let identifier: String
        
        init(identifier: String, original: Destination? = nil) {
            self.identifier = identifier
            self.original = original
        }
    }
    
    private var navigation: MockNavigation!
    
    override func setUp() {
        super.setUp()
        navigation = MockNavigation()
    }
    
    override func tearDown() {
        navigation = nil
        super.tearDown()
    }
    
    // MARK: - Basic Navigation Tests
    
    func testBasicNavigation() {
        // Arrange
        let destination = MockDestination(identifier: "test-destination")
        
        // Act
        navigation.go(to: destination)
        
        // Assert
        XCTAssertNotNil(navigation.lastDestination)
        XCTAssertNil(navigation.lastReplaceValue)
        XCTAssertTrue(navigation.lastDestination is MockDestination)
        
        if let mockDest = navigation.lastDestination as? MockDestination {
            XCTAssertEqual(mockDest.identifier, "test-destination")
        } else {
            XCTFail("Destination is not of expected type")
        }
    }
    
    func testNavigationWithReplace() {
        // Arrange
        let destination = MockDestination(identifier: "replace-destination")
        
        // Act - With replace = true
        navigation.go(to: destination, replace: true)
        
        // Assert
        XCTAssertNotNil(navigation.lastDestination)
        XCTAssertNotNil(navigation.lastReplaceValue)
        XCTAssertEqual(navigation.lastReplaceValue, true)
        
        if let mockDest = navigation.lastDestination as? MockDestination {
            XCTAssertEqual(mockDest.identifier, "replace-destination")
        } else {
            XCTFail("Destination is not of expected type")
        }
        
        // Act - With replace = false
        navigation.go(to: MockDestination(identifier: "add-destination"), replace: false)
        
        // Assert
        XCTAssertEqual(navigation.lastReplaceValue, false)
        
        if let mockDest = navigation.lastDestination as? MockDestination {
            XCTAssertEqual(mockDest.identifier, "add-destination")
        } else {
            XCTFail("Destination is not of expected type")
        }
    }
    
    func testNavigationWithOriginalDestination() {
        // Arrange
        let originalDest = MockDestination(identifier: "original")
        let derivedDest = MockDestination(identifier: "derived", original: originalDest)
        
        // Act
        navigation.go(to: derivedDest)
        
        // Assert
        XCTAssertNotNil(navigation.lastDestination)
        
        if let mockDest = navigation.lastDestination as? MockDestination {
            XCTAssertEqual(mockDest.identifier, "derived")
            XCTAssertNotNil(mockDest.original)
            
            if let original = mockDest.original as? MockDestination {
                XCTAssertEqual(original.identifier, "original")
            } else {
                XCTFail("Original destination is not of expected type")
            }
        } else {
            XCTFail("Destination is not of expected type")
        }
    }
} 