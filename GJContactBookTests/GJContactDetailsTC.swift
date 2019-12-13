//
//  GJContactDetailsTC.swift
//  GJContactBookTests
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import XCTest
@testable import GJContactBook


class GJContactDetailsTC: XCTestCase {
    var serviceManager: MockAPIService?
    var contact: GJContact?
    let bundle  = Bundle.init(for: GJContactDetailsTC.self)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serviceManager = MockAPIService()
        _ = bundle.path(forResource: "ContactListMockResponse", ofType: "json")
        contact = MockAPIService().getSomeMockListAPIData().first
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        serviceManager = nil
    }
    func testContactsDetailsVMFetch() {
        
        let viewModel = GJContactDetailsVM(contact: self.contact!, router: nil,apiManager: self.serviceManager!)
        
        let expectaion = self.expectation(description: "ContactDetailsViewModel api response")
        viewModel.handler = { type in
            switch type {
            case .reload:
                XCTAssertEqual(viewModel.numberOfRows(section: 1), 2)
                XCTAssert(viewModel.profileImageURL() == self.contact!.profilePic)
                XCTAssert(viewModel.isFavorite() == self.contact!.favorite)
                XCTAssert(viewModel.name() == self.contact!.firstName + " " + self.contact!.lastName)
                expectaion.fulfill()
            default:
                break;
            }
            
        }
        viewModel.viewDidLoadAPICall()
        
        self.waitForExpectations(timeout: 3) { (error) in
            
        }
        
    }
    
    
    
}
