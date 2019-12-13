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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ContactDetailVC") as? GJContactDetailsVC {
            let router = GJContactDetailRouter(parent: viewController)
            viewController.viewModel = GJContactDetailsVM(contact: contact, router: router)
            parent?.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    private func addContact() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "EditContactVC") as? GJEditContactVC {
            viewController.viewModel = GJEditContactVM(contact: nil)
            parent?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
