//
//  GJContactDetailsVM.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJContactDetailsVM {
    var handler: ((_ type: ViewContactEventType) -> Void)?
    var apiManager: GJAPIServices
    var contact: GJContact
    var contactDetails: GJContactDetails?
    var tableArr:[(title: String, value: String)] = []
    var router: GJContactDetailRouter?
    
    init(contact: GJContact, router: GJContactDetailRouter? = nil, apiManager: GJAPIServices =  GJAPIServicesHanlder.shared) {
        self.apiManager = apiManager
        self.contact = contact
        self.router = router
    }

    func viewDidLoadAPICall() {
        loadContactDetails()
    }
    
    func isFavorite() -> Bool {
        if let contactDetails = self.contactDetails {
            return contactDetails.favorite
        }
        return contact.favorite
    }
    func profileImageURL() -> String {
        return contact.profilePic
    }
    
    
    func name() -> String {
        return contact.firstName + " " + contact.lastName
    }
    private func loadContactDetails() {
        self.handler?(.showLoader)
        let request = GJNetworkManager.contactDetails(url: contact.url)
        apiManager.request(type: GJContactDetails.self, request) {[weak self] (response, urlResponse, error) in
            self?.handler?(.hideLoader)
            if let response = response as? GJContactDetails {
                self?.contactDetails = response
                self?.tableArr = []
                self?.tableArr.append((title: "mobile", value: response.phoneNumber))
                self?.tableArr.append((title: "email", value: response.email))
                self?.handler?(.reload)
            }
            
        }
    }
    func editClicked() {
        if let contact = self.contactDetails {
            self.router?.open(type: .edit(contact: contact))
        }
        
        
        
    }
    
    
    func favClicked() {
        let request = GJNetworkManager.updateContact(id: contact.id, firstName: nil , lastName: nil, email: nil, mobile: nil, isFavorite: !isFavorite())
        self.handler?(.showLoader)
        apiManager.request(type: GJContactDetails.self, request) {[weak self] (responseObj, urlResponse, error) in
            self?.handler?(.hideLoader)
            if let responseObj = responseObj as? GJContactDetails {
                self?.contactDetails = responseObj
                self?.handler?(.reload)
            }
        }
    }
    
    
    func numberOfRows(section: Int) -> Int {
        return tableArr.count
    }
    
    func item(indexPath: IndexPath) -> (title: String, value: String)? {
        return tableArr[indexPath.row]
    }
}
