import XCTest
@testable import SalesforceNetwork

final class NetworkTests: XCTestCase {
    
    // Mock implementation of Network protocol for testing
    private class MockNetwork: Network {
        var lastRequest: NetworkRequest?
        var responseToReturn: (Data, URLResponse)?
        var shouldThrowError: Bool = false
        var error: Error = NSError(domain: "MockNetworkError", code: 0, userInfo: nil)
        
        func data(for request: NetworkRequest) async throws -> (Data, URLResponse) {
            lastRequest = request
            
            if shouldThrowError {
                throw error
            }
            
            if let response = responseToReturn {
                return response
            }
            
            // Default mock response if none provided
            let data = "Success".data(using: .utf8)!
            let response = HTTPURLResponse(
                url: request.baseRequest.url ?? URL(string: "https://example.com")!,
                statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )!
            
            return (data, response)
        }
    }
    
    private var mockNetwork: MockNetwork!
    
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetwork()
    }
    
    override func tearDown() {
        mockNetwork = nil
        super.tearDown()
    }
    
    func testSuccessfulRequest() async throws {
        // Arrange
        let url = URL(string: "https://example.com")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let networkRequest = NetworkRequest(baseRequest: urlRequest)
        
        // Configure mock
        let expectedData = "Test response".data(using: .utf8)!
        let expectedResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: ["Content-Type": "application/json"]
        )!
        mockNetwork.responseToReturn = (expectedData, expectedResponse)
        
        // Act
        let (data, response) = try await mockNetwork.data(for: networkRequest)
        
        // Assert
        XCTAssertEqual(data, expectedData)
        XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 200)
        XCTAssertEqual(mockNetwork.lastRequest?.baseRequest.url, url)
        XCTAssertEqual(mockNetwork.lastRequest?.baseRequest.httpMethod, "GET")
    }
    
    func testFailedRequest() async {
        // Arrange
        let url = URL(string: "https://example.com")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let networkRequest = NetworkRequest(baseRequest: urlRequest)
        
        // Configure mock
        mockNetwork.shouldThrowError = true
        mockNetwork.error = NSError(domain: "TestError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        
        // Act & Assert
        do {
            _ = try await mockNetwork.data(for: networkRequest)
            XCTFail("Expected error was not thrown")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "TestError")
            XCTAssertEqual(error.code, 500)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
        
        XCTAssertEqual(mockNetwork.lastRequest?.baseRequest.url, url)
        XCTAssertEqual(mockNetwork.lastRequest?.baseRequest.httpMethod, "POST")
    }
} 