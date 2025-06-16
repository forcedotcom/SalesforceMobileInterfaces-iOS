import XCTest
@testable import SalesforceNetwork

final class NetworkRequestTests: XCTestCase {
    
    func testInitialization() {
        // Arrange
        let url = URL(string: "https://example.com")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // Act
        let networkRequest = NetworkRequest(baseRequest: urlRequest)
        
        // Assert
        XCTAssertEqual(networkRequest.baseRequest.url, url)
        XCTAssertEqual(networkRequest.baseRequest.httpMethod, "GET")
        XCTAssertNil(networkRequest.requiresAuthentication)
        XCTAssertNil(networkRequest.requiresSFAPAuthentication)
        XCTAssertTrue(networkRequest.shouldRefreshOn403)
    }
    
    func testModifyingProperties() {
        // Arrange
        let url = URL(string: "https://example.com")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // Act
        var networkRequest = NetworkRequest(baseRequest: urlRequest)
        networkRequest.requiresAuthentication = true
        networkRequest.requiresSFAPAuthentication = false
        networkRequest.shouldRefreshOn403 = false
        
        // Modify base request
        var modifiedBaseRequest = networkRequest.baseRequest
        modifiedBaseRequest.httpMethod = "POST"
        networkRequest.baseRequest = modifiedBaseRequest
        
        // Assert
        XCTAssertEqual(networkRequest.baseRequest.httpMethod, "POST")
        XCTAssertTrue(networkRequest.requiresAuthentication!)
        XCTAssertFalse(networkRequest.requiresSFAPAuthentication!)
        XCTAssertFalse(networkRequest.shouldRefreshOn403)
    }
    
    func testBaseRequestWithHeaders() {
        // Arrange
        let url = URL(string: "https://example.com")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        
        // Act
        let networkRequest = NetworkRequest(baseRequest: urlRequest)
        
        // Assert
        XCTAssertEqual(networkRequest.baseRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(networkRequest.baseRequest.value(forHTTPHeaderField: "Accept-Encoding"), "gzip")
    }
    
    func testBaseRequestWithBody() {
        // Arrange
        let url = URL(string: "https://example.com")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let testBody = ["name": "test", "id": 123] as [String: Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: testBody)
        urlRequest.httpBody = jsonData
        
        // Act
        let networkRequest = NetworkRequest(baseRequest: urlRequest)
        
        // Assert
        XCTAssertNotNil(networkRequest.baseRequest.httpBody)
        
        // Verify body content
        if let httpBody = networkRequest.baseRequest.httpBody {
            let decodedBody = try! JSONSerialization.jsonObject(with: httpBody) as! [String: Any]
            XCTAssertEqual(decodedBody["name"] as? String, "test")
            XCTAssertEqual(decodedBody["id"] as? Int, 123)
        }
    }
} 