//
//  FaqHeaderTableViewCell.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class FaqHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!

    func setExpented() {
        statusButton.setImage(#imageLiteral(resourceName: "ic_dropdown_close"), for: .normal)
    }
    func setCollpased() {
        statusButton.setImage(#imageLiteral(resourceName: "ic_dropdown_open-1"), for: .normal)
    }
}

class FaqContectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contectLabel: UILabel!
}
