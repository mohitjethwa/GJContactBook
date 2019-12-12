//
//  GJContactListingVC.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 12/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJContactListingVC: GJBaseViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    var viewModel: GJContactListVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        // Do any additional setup after loading the view.
    }
    private func initViewModel() {
        viewModel = GJContactListVM(parent: self)
        viewModel.handler = {[weak self] type in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async() {
                switch type {
                case .reload:
                    self.contactsTableView.reloadData()
                case .showLoader:
                    self.activityIndicator.startAnimating()
                case .hideLoader:
                    self.activityIndicator.stopAnimating()
                case .showError(let error):
                    self.showAlert(text: error.localizedDescription)
                default:
                    break;
                }
            }
        }
        
        viewModel.apiCallViewDidLoad()
    }
    
    @IBAction func addContact(_ sender: Any) {
        viewModel.addContactClicked()
    }
    
}

extension GJContactListingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GJContactTCell") as? GJContactListTableCell {
            cell.cellContact = viewModel.item(indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath: indexPath)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionIndexForTitle()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section: section)
    }    
}
