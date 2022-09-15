//
//  ChildrenTableViewCell.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 16/07/21.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var childrenAgeTxtField: UITextField!
    @IBOutlet weak var childrenAgeLabel: UILabel!

    typealias cb = (_ text : String?) -> ()
    var completionBlock: cb?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        childrenAgeTxtField.delegate = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let cb = completionBlock else {
            return
        }
        cb(textField.text)
    }
}
