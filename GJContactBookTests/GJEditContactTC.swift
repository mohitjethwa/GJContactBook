//
//  GJEditContactTC.swift
//  GJContactBookTests
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import XCTest
@testable import GJContactBook

class GJEditContactTC: XCTestCase {
    var serviceManager: MockAPIService?
    var contact: GJContactDetails?
    let bundle  = Bundle.init(for: GJEditContactTC.self)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serviceManager = MockAPIService()
        contact = MockAPIService().getSomeMockContactDetailsData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        serviceManager = nil
        contact = nil
    }
    
    func testAddContact() {
        
        let viewModel = GJEditContactVM(contact: nil, apiManager: self.serviceManager!)
        viewModel.updateData(cellType: .email, value: "babul@gmail.com")
        viewModel.updateData(cellType: .lastName, value: "ABC")
        viewModel.updateData(cellType: .firstName, value: "ABC")
        viewModel.updateData(cellType: .phoneNumber, value: "ABC")
        let expectaion = self.expectation(description: "ContactDetailsViewModel api response")
        viewModel.handler = { type in
            switch type {
            case .showError(let error):
                XCTAssert(error.localizedDescription == "Contact Added Successfully")
                expectaion.fulfill()
            default:
                break;
            }
            
        }
        viewModel.doneButtonClicked()
        
        self.waitForExpectations(timeout: 3) { (error) in
            
        }
        
    }
    func testUpdateContact() {
        let viewModel = GJEditContactVM(contact: contact, apiManager: self.serviceManager!)
        
        let expectaion = self.expectation(description: "ContactDetailsViewModel api response")
        viewModel.handler = { type in
            switch type {
            case .showError(let error):
                XCTAssert(error.localizedDescription == "Contact Updated Successfully")
                expectaion.fulfill()
            default:
                break;
            }
            
        }
        viewModel.doneButtonClicked()
        
        self.waitForExpectations(timeout: 3) { (error) in
            
        }
    }
    
    
}
