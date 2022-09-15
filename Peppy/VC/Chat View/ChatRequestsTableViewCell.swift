//
//  ChatRequestsTableViewCell.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class ChatRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: GetFriendRequest) {
        personName.text = model.user_name
//        messageLabel.text = model.user_Interest
    }
    
}
