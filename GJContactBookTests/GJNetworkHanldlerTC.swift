//
//  GJNetworkHanldlerTC.swift
//  GJContactBookTests
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import XCTest
@testable import GJContactBook

class GJNetworkHanldlerTC: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testListAPIRequest() {
        let request = GJNetworkManager.listApiRequest
        XCTAssert(request.path == "http://gojek-contacts-app.herokuapp.com/contacts.json")
        XCTAssert(request.httpMethod == HTTPMethod.get)
        XCTAssert(request.headers["Content-Type"] == "application/json")
        XCTAssert(request.headers["Accept"] == "application/json")
        
    }
    func testUpdateAPIRequest() {
        let request = GJNetworkManager.updateContact(id: 1, firstName: nil, lastName: nil, email: nil, mobile: nil, isFavorite: nil)
        XCTAssert(request.path == "http://gojek-contacts-app.herokuapp.com/contacts/1.json")
        XCTAssert(request.httpMethod == HTTPMethod.put)
        XCTAssert(request.headers["Content-Type"] == "application/json")
        XCTAssert(request.headers["Accept"] == "application/json")
        
        
    }
    func testContactDetailsAPIRequestMethod() {
        let request = GJNetworkManager.contactDetails(url: "http://gojek-contacts-app.herokuapp.com/contacts/1.json")
        XCTAssert(request.path == "http://gojek-contacts-app.herokuapp.com/contacts/1.json")
        XCTAssert(request.httpMethod == HTTPMethod.get)
        XCTAssert(request.headers["Content-Type"] == "application/json")
        XCTAssert(request.headers["Accept"] == "application/json")
    }
    
    func testAddContactAPIRequestMethod() {
        let request = GJNetworkManager.addContact(firstName: "abc", lastName: "def", email: "ldkjas", mobile: "981383")
        XCTAssert(request.path == "http://gojek-contacts-app.herokuapp.com/contacts.json")
        XCTAssert(request.httpMethod == HTTPMethod.post)
        XCTAssert(request.headers["Content-Type"] == "application/json")
        XCTAssert(request.headers["Accept"] == "application/json")
        XCTAssert(request.params is [String : Any])
        
    }
    
}
