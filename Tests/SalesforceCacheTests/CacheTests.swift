import XCTest
@testable import SalesforceCache

final class CacheTests: XCTestCase {
    
    // Mock implementation of Cache protocol for testing
    private class MockCache: Cache {
        var savedData: [String: Data] = [:]
        var shouldThrowError: Bool = false
        var errorType: CacheError = .invalidData
        
        func save(_ data: Data, key: String) async throws {
            if shouldThrowError {
                throw errorType
            }
            
            if key.isEmpty {
                throw CacheError.invalidKey
            }
            
            savedData[key] = data
        }
        
        func load(_ key: String) async throws -> Data? {
            if shouldThrowError {
                throw errorType
            }
            
            if key.isEmpty {
                throw CacheError.invalidKey
            }
            
            return savedData[key]
        }
        
        func remove(_ key: String) async throws {
            if shouldThrowError {
                throw errorType
            }
            
            if key.isEmpty {
                throw CacheError.invalidKey
            }
            
            savedData.removeValue(forKey: key)
        }
        
        func removeAll() async throws {
            if shouldThrowError {
                throw errorType
            }
            
            savedData.removeAll()
        }
    }
    
    private var mockCache: MockCache!
    
    override func setUp() {
        super.setUp()
        mockCache = MockCache()
    }
    
    override func tearDown() {
        mockCache = nil
        super.tearDown()
    }
    
    // MARK: - Save Tests
    
    func testSuccessfulSave() async throws {
        // Arrange
        let key = "testKey"
        let testData = "Test data".data(using: .utf8)!
        
        // Act
        try await mockCache.save(testData, key: key)
        
        // Assert
        XCTAssertEqual(mockCache.savedData[key], testData)
    }
    
    func testSaveWithInvalidKey() async {
        // Arrange
        let key = ""
        let testData = "Test data".data(using: .utf8)!
        
        // Act & Assert
        do {
            try await mockCache.save(testData, key: key)
            XCTFail("Expected error was not thrown")
        } catch let error as CacheError {
            XCTAssertEqual(error, CacheError.invalidKey)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testSaveWithError() async {
        // Arrange
        let key = "testKey"
        let testData = "Test data".data(using: .utf8)!
        mockCache.shouldThrowError = true
        mockCache.errorType = .invalidData
        
        // Act & Assert
        do {
            try await mockCache.save(testData, key: key)
            XCTFail("Expected error was not thrown")
        } catch let error as CacheError {
            XCTAssertEqual(error, CacheError.invalidData)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // MARK: - Load Tests
    
    func testSuccessfulLoad() async throws {
        // Arrange
        let key = "testKey"
        let testData = "Test data".data(using: .utf8)!
        mockCache.savedData[key] = testData
        
        // Act
        let result = try await mockCache.load(key)
        
        // Assert
        XCTAssertEqual(result, testData)
    }
    
    func testLoadNonExistentKey() async throws {
        // Arrange
        let key = "nonExistentKey"
        
        // Act
        let result = try await mockCache.load(key)
        
        // Assert
        XCTAssertNil(result)
    }
    
    func testLoadWithInvalidKey() async {
        // Arrange
        let key = ""
        
        // Act & Assert
        do {
            _ = try await mockCache.load(key)
            XCTFail("Expected error was not thrown")
        } catch let error as CacheError {
            XCTAssertEqual(error, CacheError.invalidKey)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testLoadWithError() async {
        // Arrange
        let key = "testKey"
        mockCache.shouldThrowError = true
        mockCache.errorType = .invalidOperation
        
        // Act & Assert
        do {
            _ = try await mockCache.load(key)
            XCTFail("Expected error was not thrown")
        } catch let error as CacheError {
            XCTAssertEqual(error, CacheError.invalidOperation)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // MARK: - Remove Tests
    
    func testSuccessfulRemove() async throws {
        // Arrange
        let key = "testKey"
        let testData = "Test data".data(using: .utf8)!
        mockCache.savedData[key] = testData
        
        // Act
        try await mockCache.remove(key)
        
        // Assert
        XCTAssertNil(mockCache.savedData[key])
    }
    
    func testRemoveWithInvalidKey() async {
        // Arrange
        let key = ""
        
        // Act & Assert
        do {
            try await mockCache.remove(key)
            XCTFail("Expected error was not thrown")
        } catch let error as CacheError {
            XCTAssertEqual(error, CacheError.invalidKey)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testRemoveWithError() async {
        // Arrange
        let key = "testKey"
        mockCache.shouldThrowError = true
        mockCache.errorType = .invalidOperation
        
        // Act & Assert
        do {
            try await mockCache.remove(key)
            XCTFail("Expected error was not thrown")
        } catch let error as CacheError {
            XCTAssertEqual(error, CacheError.invalidOperation)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // MARK: - RemoveAll Tests
    
    func testSuccessfulRemoveAll() async throws {
        // Arrange
        mockCache.savedData = [
            "key1": "Data 1".data(using: .utf8)!,
            "key2": "Data 2".data(using: .utf8)!
        ]
        
        // Act
        try await mockCache.removeAll()
        
        // Assert
        XCTAssertTrue(mockCache.savedData.isEmpty)
    }
    
    func testRemoveAllWithError() async {
        // Arrange
        mockCache.savedData = [
            "key1": "Data 1".data(using: .utf8)!,
            "key2": "Data 2".data(using: .utf8)!
        ]
        mockCache.shouldThrowError = true
        mockCache.errorType = .invalidOperation
        
        // Act & Assert
        do {
            try await mockCache.removeAll()
            XCTFail("Expected error was not thrown")
        } catch let error as CacheError {
            XCTAssertEqual(error, CacheError.invalidOperation)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
        
        // Make sure data wasn't cleared
        XCTAssertEqual(mockCache.savedData.count, 2)
    }
} 