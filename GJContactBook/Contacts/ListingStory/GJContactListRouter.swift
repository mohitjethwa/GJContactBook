//
//  GJContactListRouter.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 12/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJContactListRouter {
    
    enum ContactListRoutingTypes{
        case details(contact: GJContact)
        case addContact
    }
    
    var parent: GJContactListingVC?
    init(parent: GJContactListingVC) {
        self.parent = parent
    }
    
    func open(type: ContactListRoutingTypes) {
        switch type {
        case .details(let contact):
            openDetailsPage(contact: contact)
        case .addContact:
            addContact()
        }
    }
    private func openDetailsPage(contact: GJContact) {
        
    }
    
    private func addContact() {
        
    }
}
