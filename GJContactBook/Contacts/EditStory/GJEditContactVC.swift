//
//  GJEditContactVC.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJEditContactVC: GJBaseViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var profileImageView: GJImageView!
    var viewModel: GJEditContactVM!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderData()
        let downColor = UIColor(displayP3Red: 80.0/225.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 0.154)
        headerView.addGradient(firstColor: .white, secondColor: downColor)
        viewModel.handler = {[weak self] type in
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
                case .popView:
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }
    }
    
    func setupHeaderData() {
        if let url = viewModel.profileImageURL() {
            profileImageView.loadImage(url: url, placeHolder:  UIImage(named: "placeholder_photo")) { (completed) in
                
            }
        }
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        self.view.endEditing(true)
        viewModel.doneButtonClicked()
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension GJEditContactVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GJEditContactTableCell") as? GJEditContactTableCell {
            let obj = viewModel.item(indexPath: indexPath)
            cell.config(cellType: obj, vieWModel: viewModel)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    
}
