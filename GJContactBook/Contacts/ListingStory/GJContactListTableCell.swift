//
//  GJContactListTableCell.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 12/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJContactListTableCell: UITableViewCell {
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var contactTitle: UILabel!
    @IBOutlet weak var contactImageView: GJImageView!
    var cellContact: GJContact! {
        didSet {
            self.favButton.isSelected = cellContact.favorite
            self.contactTitle.text = cellContact.firstName
            self.contactImageView.loadImage(url:  cellContact.profilePic, placeHolder: UIImage(named: "placeholder_photo")) { (completed) in
                
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func favClicked(_ sender: Any) {
    }
}
