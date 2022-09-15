//
//  ReceiverCell.swift
//  Peppy
//
//  Created by Admin on 11/08/21.
//

import UIKit

class ReceiverCell: UITableViewCell {

    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var msgTextLabel: UILabel!
    @IBOutlet weak var receiverView: UIView!
    
    static let indentifier = "ReceiverCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        receiverView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMinYCorner]
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(message: Message){
        msgTextLabel.text = message.msg
        timeTextLabel.text = message.timeStamp
    }

}
