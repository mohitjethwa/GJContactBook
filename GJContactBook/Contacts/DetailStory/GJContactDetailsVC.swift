//
//  GJContactDetailsVC.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJContactDetailsVC: GJBaseViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var favView: UIView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var profileImageView: GJImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var viewModel: GJContactDetailsVM!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderData()
        let downColor = UIColor(displayP3Red: 80.0/225.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 0.154)
        headerView.addGradient(firstColor: .white, secondColor: downColor)
        viewModel.handler = { [weak self] type in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async() {
                
                switch type {
                case .reload:
                    self.setupHeaderData()
                    self.tableView.reloadData()
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
        viewModel.viewDidLoadAPICall()
        
        // Do any additional setup after loading the view.
    }
    func setupHeaderData() {
        self.favButton.isSelected = viewModel.isFavorite()
        self.nameLabel.text = viewModel.name()
        profileImageView.loadImage(url: viewModel.profileImageURL(), placeHolder:  UIImage(named: "placeholder_photo")) { (completed) in
            
        }
        
    }
    
    
    @IBAction func callClicked(_ sender: Any) {
        
    }
    @IBAction func favoriteClicked(_ sender: Any) {
        favButton.isSelected = !favButton.isSelected
        viewModel.favClicked()
    }
    
    @IBAction func editClicked(_ sender: Any) {
        viewModel.editClicked()
    }
}

extension GJContactDetailsVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GJContactDetailsTableCell") as? GJContactDetailsTableCell {
            let obj = viewModel.item(indexPath: indexPath)
            cell.configData(title: obj?.title, value: obj?.value)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    
}
