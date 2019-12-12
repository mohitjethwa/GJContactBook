//
//  GJContactListVM.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 12/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

enum ViewContactEventType {
    case reload
    case showLoader
    case hideLoader
    case showError(error: Error)
    case popView
    
}


struct Section {
    let letter: String
    let contacts: [GJContact]
    init(letter: String, contacts: [GJContact]) {
        self.letter = letter
        self.contacts = contacts
    }
}


class GJContactListVM: NSObject {
    var handler: ((_ type: ViewContactEventType) -> Void)?
    private var sections:[Section] = []
    var apiManager: GJAPIServices
    var router: GJContactListRouter?
    init(apiManager: GJAPIServices = GJAPIServicesHanlder.shared, parent: GJContactListingVC? = nil) {
        self.apiManager = apiManager
        if let parent = parent {
            router = GJContactListRouter(parent: parent)
        }
        
    }
    
    func apiCallViewDidLoad() {
        let request: GJNetworkManager = GJNetworkManager.listApiRequest
        handler?(.showLoader)
        apiManager.request(type: [GJContact].self, request) {[weak self](responseObj, urlResponse, error) in
            guard let self  = self else {
                return
            }
            self.handler?(.hideLoader)
            if let error = error {
                self.handler?(.showError(error: error))
            } else if let responseObj = responseObj as? [GJContact] {
                self.sortedSection(contacts: responseObj)
                
            }
        }
    }
    
    func sortedSection(contacts: [GJContact]) {
        let groupedDictionary = Dictionary(grouping: contacts, by: {String($0.firstName.uppercased().prefix(1))})
        // get the keys and sort them
        let keys = groupedDictionary.keys.sorted()
        // map the sorted keys to a struct
        sections = keys.map{ Section(letter: $0, contacts: groupedDictionary[$0]!.sorted()) }
        self.handler?(.reload)
        
    }
    func addContactClicked() {
        self.router?.open(type: .addContact)
    }
}


// TableViewEvents
extension GJContactListVM {
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(section: Int) -> Int {
        return sections[section].contacts.count
    }
    func item(indexPath: IndexPath) -> GJContact {
        return sections[indexPath.section].contacts[indexPath.row]
    }
    
    func sectionIndexForTitle() -> [String] {
        return sections.map{$0.letter}
    }
    func titleForSection(section: Int) -> String {
        return sections[section].letter
    }
    func didSelectRow(indexPath: IndexPath) {
        let item = self.item(indexPath: indexPath)
        self.router?.open(type: .details(contact: item))
    }
}
