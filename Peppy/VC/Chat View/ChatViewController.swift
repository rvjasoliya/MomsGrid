//
//  ChatViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatTableView: UITableView!
    
    var chatTap = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        GetFriendApi()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        GetFriendApi()
    }

    func GetFriendApi() {
        NetworkManager.GetFriendApi(param: [:]) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                getFriend = GetFriend.modelsFromDictionaryArray(array: data?["Data"] as Any as? NSArray ?? [])
                self.chatTableView.reloadData()
            }
        }
    }
    
    func getLastMsg(friend_uuid: String, completionHandler: @escaping (Message?, NSError?)->()) ->() {
        let msgDB = Database.database().reference().child("Chats").child(userDetail?.uuid ?? "").child(friend_uuid)
        msgDB.queryOrderedByKey().queryLimited(toLast: 1).observe(.childAdded) { (snapshot) in
            print(snapshot)
            if let value = snapshot.value as? [String: AnyObject] {
                print(value as Any)
                let msg = Message(dictionary: value)
                completionHandler(msg,nil)
            }else {
                print(snapshot)
                completionHandler(nil,nil)
            }
        }
    }
}


extension ChatViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getFriend.count == 0{
            tableView.setEmptyMessage("Data Not Found!..")
        } else {
            tableView.restore()
        }
        return getFriend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = getFriend[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! chatTableViewCell
        if (model.friend_profile ?? "") == "" {
            cell.profileImageView.image = UIImage(named: "user")
        } else{
            cell.profileImageView.sd_setImage(with: URL(string: imageUrl + (model.friend_profile ?? "")) , completed: nil)
        }
        cell.personName.text = model.friend_name
        cell.messageLabel.text = ""
        cell.timeLabel.text = ""
        if let uuid = model.friend_uuid {
            getLastMsg(friend_uuid: uuid) { (message, error) in
                if let messageData = message {
                    cell.messageLabel.text = messageData.msg ?? ""
                    cell.timeLabel.text = messageData.timeStamp ?? ""
                } else{
                    cell.messageLabel.text = ""
                    cell.timeLabel.text = ""
                }
            }
        } else{
            cell.messageLabel.text = ""
            cell.timeLabel.text = ""
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = getFriend[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChattingVC") as! ChattingViewController
        vc.nameSave = model.friend_name
        vc.other_user_uuid = model.uuid
        vc.friend_uuid = model.friend_uuid
        vc.chatTap = chatTap
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
