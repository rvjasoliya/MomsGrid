//
//  SenderTableViewCell.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class SenderTableViewCell: UITableViewCell {

    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var msgTextLabel: UILabel!
    @IBOutlet weak var deliveredTextLabel: UILabel!
    @IBOutlet weak var senderView: UIView!
    
    
    static let indentifier = "SenderCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        senderView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
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
