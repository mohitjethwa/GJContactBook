 //
//  GJContactListTC.swift
//  GJContactBookTests
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

 import XCTest
 @testable import GJContactBook

 class GJContactListTC: XCTestCase {
    var serviceManager: MockAPIService?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serviceManager = MockAPIService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        serviceManager = nil
    }
    func testContactsListVMFetchList() {
        let viewModel = GJContactListVM(apiManager: self.serviceManager!, parent: nil)
        
        let expectaion = self.expectation(description: "ContactListViewModel api response")
        viewModel.handler = { type in
            switch type {
            case .reload:
                XCTAssertEqual(viewModel.numberOfSections(), 26)
                XCTAssertEqual(viewModel.numberOfRows(section: 1), 13)
                expectaion.fulfill()
            default:
                break;
            }
            
        }
        viewModel.apiCallViewDidLoad()
        
        self.waitForExpectations(timeout: 3) { (error) in
            
        }
        
    }
    
    
 }
