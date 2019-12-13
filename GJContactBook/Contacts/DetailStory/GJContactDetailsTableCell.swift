//
//  GJContactDetailsTableCell.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJContactDetailsTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func configData(title: String?, value: String?) {
        titleLbl.text = title
        valueLabel.text = value
    }
    
}
