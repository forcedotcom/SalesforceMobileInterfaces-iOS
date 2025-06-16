import XCTest
@testable import SalesforceNetwork

final class NetworkIntegrationTests: XCTestCase {
    
    // Simple Network implementation for testing
    private class TestNetwork: Network {
        var lastRequest: NetworkRequest?
        var simulatedResponseData: Data
        var simulatedStatusCode: Int
        
        init(simulatedResponseData: Data = Data(), simulatedStatusCode: Int = 200) {
            self.simulatedResponseData = simulatedResponseData
            self.simulatedStatusCode = simulatedStatusCode
        }
        
        func data(for request: NetworkRequest) async throws -> (Data, URLResponse) {
            lastRequest = request
            
            // If the status code is in error range, throw an error
            if simulatedStatusCode >= 400 {
                throw NSError(
                    domain: "TestNetworkError",
                    code: simulatedStatusCode,
                    userInfo: [NSLocalizedDescriptionKey: "HTTP Error \(simulatedStatusCode)"]
                )
            }
            
            // Create simulated response
            let response = HTTPURLResponse(
                url: request.baseRequest.url ?? URL(string: "https://example.com")!,
                statusCode: simulatedStatusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )!
            
            return (simulatedResponseData, response)
        }
    }
    
    func testBasicNetworkRequestFlow() async throws {
        // Arrange
        let responseBody = """
        {
            "id": "12345",
            "name": "Test Record",
            "success": true
        }
        """
        let responseData = responseBody.data(using: .utf8)!
        let network = TestNetwork(simulatedResponseData: responseData)
        
        // Create network request
        let url = URL(string: "https://api.example.com/records/12345")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var networkRequest = NetworkRequest(baseRequest: urlRequest)
        networkRequest.requiresAuthentication = true
        
        // Act
        let (data, response) = try await network.data(for: networkRequest)
        
        // Assert
        // Verify response
        XCTAssertEqual(data, responseData)
        XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 200)
        
        // Verify request was passed correctly
        XCTAssertEqual(network.lastRequest?.baseRequest.url, url)
        XCTAssertEqual(network.lastRequest?.baseRequest.httpMethod, "GET")
        XCTAssertEqual(network.lastRequest?.baseRequest.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(network.lastRequest?.requiresAuthentication, true)
        
        // Parse the response
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        XCTAssertEqual(json["id"] as? String, "12345")
        XCTAssertEqual(json["name"] as? String, "Test Record")
        XCTAssertEqual(json["success"] as? Bool, true)
    }
    
    func testErrorHandling() async {
        // Arrange
        let network = TestNetwork(simulatedStatusCode: 404)
        
        let url = URL(string: "https://api.example.com/nonexistent")!
        let urlRequest = URLRequest(url: url)
        let networkRequest = NetworkRequest(baseRequest: urlRequest)
        
        // Act & Assert
        do {
            _ = try await network.data(for: networkRequest)
            XCTFail("Expected error was not thrown")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "TestNetworkError")
            XCTAssertEqual(error.code, 404)
        }
        
        // Verify request was passed correctly before error
        XCTAssertEqual(network.lastRequest?.baseRequest.url, url)
    }
    
    func testAuthenticatedRequest() async throws {
        // Arrange
        let responseData = "Authenticated response".data(using: .utf8)!
        let network = TestNetwork(simulatedResponseData: responseData)
        
        let url = URL(string: "https://api.salesforce.com/services/data/v55.0/sobjects/Account")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        // Example account data
        let accountData = ["Name": "Test Account", "Industry": "Technology"]
        let jsonData = try JSONSerialization.data(withJSONObject: accountData)
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var networkRequest = NetworkRequest(baseRequest: urlRequest)
        networkRequest.requiresAuthentication = true
        networkRequest.requiresSFAPAuthentication = false
        
        // Act
        let (data, response) = try await network.data(for: networkRequest)
        
        // Assert
        XCTAssertEqual(data, responseData)
        XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 200)
        
        // Verify authentication flags were passed correctly
        XCTAssertEqual(network.lastRequest?.requiresAuthentication, true)
        XCTAssertEqual(network.lastRequest?.requiresSFAPAuthentication, false)
    }
} 