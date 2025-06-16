import XCTest
@testable import SalesforceCache

final class CacheIntegrationTests: XCTestCase {
    
    // In-memory implementation of Cache protocol for integration testing
    private class InMemoryCache: Cache {
        var storage: [String: Data] = [:]
        
        func save(_ data: Data, key: String) async throws {
            if key.isEmpty {
                throw CacheError.invalidKey
            }
            storage[key] = data
        }
        
        func load(_ key: String) async throws -> Data? {
            if key.isEmpty {
                throw CacheError.invalidKey
            }
            return storage[key]
        }
        
        func remove(_ key: String) async throws {
            if key.isEmpty {
                throw CacheError.invalidKey
            }
            storage.removeValue(forKey: key)
        }
        
        func removeAll() async throws {
            storage.removeAll()
        }
    }
    
    private var cache: InMemoryCache!
    
    override func setUp() {
        super.setUp()
        cache = InMemoryCache()
    }
    
    override func tearDown() {
        cache = nil
        super.tearDown()
    }
    
    // Integration test for caching and retrieving structured data
    func testCachingAndRetrievingJSON() async throws {
        // Arrange
        struct TestData: Codable, Equatable {
            let id: String
            let value: Int
            let items: [String]
        }
        
        let testObject = TestData(
            id: "test-123",
            value: 42,
            items: ["item1", "item2", "item3"]
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let key = "test-json-data"
        let encodedData = try encoder.encode(testObject)
        
        // Act - Save data
        try await cache.save(encodedData, key: key)
        
        // Act - Load data
        let retrievedData = try await cache.load(key)
        
        // Assert
        XCTAssertNotNil(retrievedData)
        
        if let retrievedData = retrievedData {
            let decodedObject = try decoder.decode(TestData.self, from: retrievedData)
            XCTAssertEqual(decodedObject, testObject)
        }
    }
    
    // Integration test for handling large data
    func testHandlingLargeData() async throws {
        // Arrange
        let key = "large-data"
        let size = 1024 * 1024 // 1MB
        var largeData = Data(count: size)
        
        // Fill with some pattern
        for i in 0..<size {
            largeData[i] = UInt8(i % 256)
        }
        
        // Act
        try await cache.save(largeData, key: key)
        let retrievedData = try await cache.load(key)
        
        // Assert
        XCTAssertNotNil(retrievedData)
        XCTAssertEqual(retrievedData, largeData)
    }
    
    // Integration test for cache operations sequence
    func testCacheOperationsSequence() async throws {
        // Arrange
        let keys = ["key1", "key2", "key3"]
        let dataValues = [
            "Data for key1".data(using: .utf8)!,
            "Data for key2".data(using: .utf8)!,
            "Data for key3".data(using: .utf8)!
        ]
        
        // Act & Assert - Save multiple items
        for (index, key) in keys.enumerated() {
            try await cache.save(dataValues[index], key: key)
        }
        
        // Verify all items were saved
        for (index, key) in keys.enumerated() {
            let data = try await cache.load(key)
            XCTAssertEqual(data, dataValues[index])
        }
        
        // Remove one item
        try await cache.remove(keys[1])
        
        // Verify item was removed
        let removedItemData = try await cache.load(keys[1])
        XCTAssertNil(removedItemData)
        
        // Verify other items still exist
        let item0Data = try await cache.load(keys[0])
        let item2Data = try await cache.load(keys[2])
        XCTAssertEqual(item0Data, dataValues[0])
        XCTAssertEqual(item2Data, dataValues[2])
        
        // Clear all items
        try await cache.removeAll()
        
        // Verify all items were cleared
        for key in keys {
            let data = try await cache.load(key)
            XCTAssertNil(data)
        }
    }
} 
