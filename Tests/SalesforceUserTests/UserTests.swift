import XCTest
@testable import SalesforceUser

final class UserTests: XCTestCase {
    
    // MARK: - Community Tests
    
    func testCommunityInitialization() {
        // Arrange
        let communityId = "0DBxx0000004CAy"
        
        // Act
        let community = Community(id: communityId)
        
        // Assert
        XCTAssertEqual(community.id, communityId)
    }
    
    // MARK: - Org Tests
    
    func testOrgInitializationWithoutCommunity() {
        // Arrange
        let orgId = "00Dxx0000001gPL"
        
        // Act
        let org = Org(id: orgId)
        
        // Assert
        XCTAssertEqual(org.id, orgId)
        XCTAssertNil(org.community)
    }
    
    func testOrgInitializationWithCommunity() {
        // Arrange
        let orgId = "00Dxx0000001gPL"
        let communityId = "0DBxx0000004CAy"
        let community = Community(id: communityId)
        
        // Act
        let org = Org(id: orgId, community: community)
        
        // Assert
        XCTAssertEqual(org.id, orgId)
        XCTAssertNotNil(org.community)
        XCTAssertEqual(org.community?.id, communityId)
    }
    
    // MARK: - User Tests
    
    func testUserInitializationWithMinimalParameters() {
        // Arrange
        let userId = "005xx000001SwiP"
        let orgId = "00Dxx0000001gPL"
        let org = Org(id: orgId)
        let username = "test@example.com"
        let displayName = "Test User"
        
        // Act
        let user = User(userId: userId, org: org, username: username, displayName: displayName)
        
        // Assert
        XCTAssertEqual(user.userId, userId)
        XCTAssertEqual(user.org.id, orgId)
        XCTAssertEqual(user.username, username)
        XCTAssertEqual(user.displayName, displayName)
        XCTAssertNil(user.firstName)
        XCTAssertNil(user.avatarURL)
    }
    
    func testUserInitializationWithAllParameters() {
        // Arrange
        let userId = "005xx000001SwiP"
        let orgId = "00Dxx0000001gPL"
        let communityId = "0DBxx0000004CAy"
        let community = Community(id: communityId)
        let org = Org(id: orgId, community: community)
        let username = "test@example.com"
        let displayName = "Test User"
        let firstName = "Test"
        let avatarURL = URL(string: "https://example.com/avatar.jpg")!
        
        // Act
        let user = User(
            userId: userId,
            org: org,
            username: username,
            displayName: displayName,
            firstName: firstName,
            avatarURL: avatarURL
        )
        
        // Assert
        XCTAssertEqual(user.userId, userId)
        XCTAssertEqual(user.org.id, orgId)
        XCTAssertEqual(user.org.community?.id, communityId)
        XCTAssertEqual(user.username, username)
        XCTAssertEqual(user.displayName, displayName)
        XCTAssertEqual(user.firstName, firstName)
        XCTAssertEqual(user.avatarURL, avatarURL)
    }
    
    func testUserWithOrgButNoCommunity() {
        // Arrange
        let userId = "005xx000001SwiP"
        let orgId = "00Dxx0000001gPL"
        let org = Org(id: orgId)
        let username = "test@example.com"
        let displayName = "Test User"
        
        // Act
        let user = User(userId: userId, org: org, username: username, displayName: displayName)
        
        // Assert
        XCTAssertEqual(user.userId, userId)
        XCTAssertEqual(user.org.id, orgId)
        XCTAssertNil(user.org.community)
        XCTAssertEqual(user.username, username)
        XCTAssertEqual(user.displayName, displayName)
    }
    
    func testUserWithOrgAndCommunity() {
        // Arrange
        let userId = "005xx000001SwiP"
        let orgId = "00Dxx0000001gPL"
        let communityId = "0DBxx0000004CAy"
        let community = Community(id: communityId)
        let org = Org(id: orgId, community: community)
        let username = "test@example.com"
        let displayName = "Test User"
        
        // Act
        let user = User(userId: userId, org: org, username: username, displayName: displayName)
        
        // Assert
        XCTAssertEqual(user.userId, userId)
        XCTAssertEqual(user.org.id, orgId)
        XCTAssertNotNil(user.org.community)
        XCTAssertEqual(user.org.community?.id, communityId)
        XCTAssertEqual(user.username, username)
        XCTAssertEqual(user.displayName, displayName)
    }
} 