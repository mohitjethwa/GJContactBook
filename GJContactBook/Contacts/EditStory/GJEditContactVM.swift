//
//  GJEditContactVM.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJEditContactVM {
    var handler: ((_ type: ViewContactEventType) -> Void)?
    var apiManager: GJAPIServices
    var contact: GJContactDetails?
    var tableArr:[EditCellType] = [.firstName,.lastName,.email,.phoneNumber]
    
    private var firstName: String?
    private var lastName: String?
    private var email: String?
    private var mobile: String?
    
    func getMobile() -> String? {
        if let mobile = self.mobile {
            return mobile
        }
        return contact?.phoneNumber
    }
    func getFirstName() -> String? {
        if let firstName = self.firstName {
            return firstName
        }
        return contact?.firstName
    }
    func getLastName() -> String? {
        if let lastName = self.lastName {
            return lastName
        }
        return contact?.lastName
    }
    func getEmail() -> String? {
        if let email = self.email {
            return email
        }
        return contact?.email
    }
    
    
    init(contact: GJContactDetails?, apiManager: GJAPIServices =  GJAPIServicesHanlder.shared) {
        self.apiManager = apiManager
        self.contact = contact
        
    }
    
    func profileImageURL() -> String? {
        return contact?.profilePic
    }
    
    
    
    func doneButtonClicked() {
        //show loader
        // validate
        // create or edit
        guard let firstName = getFirstName() else {
            let error = NSError(domain: "validation error", code: -1, userInfo: [NSLocalizedDescriptionKey: "First name is mandatory"])
            self.handler?(.showError(error: error as Error))
            return;
        }
        guard let lastName = getLastName() else {
            let error = NSError(domain: "validation error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Last name is mandatory"])
            self.handler?(.showError(error: error as Error))
            return;
        }
        guard let email = getEmail() else {
            let error = NSError(domain: "validation error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Email is mandatory"])
            self.handler?(.showError(error: error as Error))
            return;
        }
        guard let phoneNumber = getMobile() else {
            let error = NSError(domain: "validation error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Phone number is mandatory"])
            self.handler?(.showError(error: error as Error))
            return;
        }
        var request: GJNetworkManager!
        
        var sucessStr : String = "Contact Added Successfully"
        if let contact = self.contact {
            //edit
            request = GJNetworkManager.updateContact(id: contact.id, firstName: firstName , lastName: lastName, email: email, mobile: phoneNumber, isFavorite: contact.favorite)
            sucessStr  = "Contact Updated Successfully"
            
        } else {
            request = GJNetworkManager.addContact(firstName: firstName, lastName: lastName, email: email, mobile: phoneNumber)
        }
        self.handler?(.showLoader)
        apiManager.request(type: GJContactDetails.self, request) {[weak self] (responseObj, urlResponse, error) in
            self?.handler?(.hideLoader)
            if  responseObj is GJContactDetails {
                let error = NSError(domain: "Success", code: -1, userInfo: [NSLocalizedDescriptionKey: sucessStr])
                self?.handler?(.showError(error: error as Error))
                
            }
            
        }
        
    }
    
}

extension GJEditContactVM {
    
    func numberOfRows(section: Int) -> Int {
        return tableArr.count
    }
    
    func item(indexPath: IndexPath) -> EditCellType {
        let type = tableArr[indexPath.row]
        return type
        
    }
    func cellValues(type: EditCellType) -> (title: String, value: String?){
        var valueStr: String?
        switch type {
        case .firstName:
            valueStr = self.getFirstName()
        case .lastName:
            valueStr = self.getLastName()
        case .email:
            valueStr = self.getEmail()
        case .phoneNumber:
            valueStr = self.getMobile()
            
        }
        return (title: type.placeHolder(), value: valueStr)
    }
    
    
    func updateData(cellType: EditCellType, value: String?) {
        switch cellType {
        case .firstName:
            firstName = value
        case .lastName:
            lastName = value
        case .email:
            email = value
        case .phoneNumber:
            mobile  = value
        }
    }
    
}
