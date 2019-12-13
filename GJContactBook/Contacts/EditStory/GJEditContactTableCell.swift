//
//  GJEditContactTableCell.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

enum EditCellType {
    case firstName
    case lastName
    case email
    case phoneNumber
    
    func placeHolder() -> String {
        switch self {
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .email:
            return "Email"
        case .phoneNumber:
            return "Phone"
            
        }
    }
}

class GJEditContactTableCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var cellType: EditCellType!
    var viewModel: GJEditContactVM!
    
    func config(cellType: EditCellType, vieWModel: GJEditContactVM) {
        self.cellType = cellType
        self.viewModel = vieWModel
        let obj = vieWModel.cellValues(type: cellType)
        self.nameLabel.text = obj.title
        self.textField.text = obj.value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension GJEditContactTableCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.updateData(cellType: cellType, value: textField.text)
    }
}
