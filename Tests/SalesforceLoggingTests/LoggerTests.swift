import XCTest
@testable import SalesforceLogging

final class LoggerTests: XCTestCase {
    
    // Mock implementation of Logger protocol for testing
    private class MockLogger: Logger {
        var logMessages: [(message: String, level: LogLevel)] = []
        
        func log(_ logMessage: String, level: LogLevel) {
            logMessages.append((logMessage, level))
        }
    }
    
    private var logger: MockLogger!
    
    override func setUp() {
        super.setUp()
        logger = MockLogger()
    }
    
    override func tearDown() {
        logger = nil
        super.tearDown()
    }
    
    // MARK: - Logging Tests
    
    func testErrorLogging() {
        // Arrange
        let errorMessage = "Critical error occurred"
        
        // Act
        logger.log(errorMessage, level: .error)
        
        // Assert
        XCTAssertEqual(logger.logMessages.count, 1)
        XCTAssertEqual(logger.logMessages[0].message, errorMessage)
        XCTAssertEqual(logger.logMessages[0].level, .error)
    }
    
    func testWarningLogging() {
        // Arrange
        let warningMessage = "Warning: resource not found"
        
        // Act
        logger.log(warningMessage, level: .warning)
        
        // Assert
        XCTAssertEqual(logger.logMessages.count, 1)
        XCTAssertEqual(logger.logMessages[0].message, warningMessage)
        XCTAssertEqual(logger.logMessages[0].level, .warning)
    }
    
    func testInfoLogging() {
        // Arrange
        let infoMessage = "User logged in successfully"
        
        // Act
        logger.log(infoMessage, level: .info)
        
        // Assert
        XCTAssertEqual(logger.logMessages.count, 1)
        XCTAssertEqual(logger.logMessages[0].message, infoMessage)
        XCTAssertEqual(logger.logMessages[0].level, .info)
    }
    
    func testDebugLogging() {
        // Arrange
        let debugMessage = "API call parameters: {'id': 123}"
        
        // Act
        logger.log(debugMessage, level: .debug)
        
        // Assert
        XCTAssertEqual(logger.logMessages.count, 1)
        XCTAssertEqual(logger.logMessages[0].message, debugMessage)
        XCTAssertEqual(logger.logMessages[0].level, .debug)
    }
    
    func testMultipleLoggingLevels() {
        // Act
        logger.log("Error message", level: .error)
        logger.log("Warning message", level: .warning)
        logger.log("Info message", level: .info)
        logger.log("Debug message", level: .debug)
        
        // Assert
        XCTAssertEqual(logger.logMessages.count, 4)
        
        XCTAssertEqual(logger.logMessages[0].message, "Error message")
        XCTAssertEqual(logger.logMessages[0].level, .error)
        
        XCTAssertEqual(logger.logMessages[1].message, "Warning message")
        XCTAssertEqual(logger.logMessages[1].level, .warning)
        
        XCTAssertEqual(logger.logMessages[2].message, "Info message")
        XCTAssertEqual(logger.logMessages[2].level, .info)
        
        XCTAssertEqual(logger.logMessages[3].message, "Debug message")
        XCTAssertEqual(logger.logMessages[3].level, .debug)
    }
    
    func testEmptyMessage() {
        // Act
        logger.log("", level: .info)
        
        // Assert
        XCTAssertEqual(logger.logMessages.count, 1)
        XCTAssertEqual(logger.logMessages[0].message, "")
        XCTAssertEqual(logger.logMessages[0].level, .info)
    }
}

// MARK: - LogLevel Tests

final class LogLevelTests: XCTestCase {
    
    func testLogLevelEquality() {
        // Equality tests
        XCTAssertEqual(LogLevel.error, LogLevel.error)
        XCTAssertEqual(LogLevel.warning, LogLevel.warning)
        XCTAssertEqual(LogLevel.info, LogLevel.info)
        XCTAssertEqual(LogLevel.debug, LogLevel.debug)
        
        // Inequality tests
        XCTAssertNotEqual(LogLevel.error, LogLevel.warning)
        XCTAssertNotEqual(LogLevel.error, LogLevel.info)
        XCTAssertNotEqual(LogLevel.error, LogLevel.debug)
        
        XCTAssertNotEqual(LogLevel.warning, LogLevel.info)
        XCTAssertNotEqual(LogLevel.warning, LogLevel.debug)
        
        XCTAssertNotEqual(LogLevel.info, LogLevel.debug)
    }
} 