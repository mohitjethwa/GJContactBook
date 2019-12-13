//
//  GJContactDetailRouter.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJContactDetailRouter {
    enum ContactDetailRoutingTypes{
        case edit(contact: GJContactDetails)
    }
    
    var parent: GJContactDetailsVC?
    init(parent: GJContactDetailsVC) {
        self.parent = parent
    }
    
    func open(type: ContactDetailRoutingTypes) {
        switch type {
        case .edit(let contact):
            openEditPage(contact: contact)
        }
    }
    
    private func openEditPage(contact: GJContactDetails) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "EditContactVC") as? GJEditContactVC {
            viewController.viewModel = GJEditContactVM(contact: contact)
            parent?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
}
