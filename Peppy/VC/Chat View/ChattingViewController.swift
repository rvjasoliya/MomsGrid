//
//  ChattingViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChattingViewController: UIViewController {

    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var msgSendTextField: UITextField!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chatRequestMsgView: UIView!
    @IBOutlet weak var conversationTableView: UITableView!
    @IBOutlet weak var chatRequestView: UIView!
    @IBOutlet weak var chatRequestTableView: UIView!
    @IBOutlet weak var msgTxtFieldView: UIView!
    @IBOutlet weak var sayHelloView: UIView!
    
    var messageArray:[Message] = []
    var friend_uuid: String?
    var imageSave: String?
    var nameSave: String?
    var request_uuid: String?
    var other_user_uuid: String?
    var chateBtnHideShow : Bool?
    var msgBtnHideAndShow : Bool?
    var chatTap: Bool?
    var acceptBtnHideAndShow : Bool?
    var profileDetailTap: Bool?
    var selectedButton: Int? = 0
    
//    var msglist =  [String: Any]()
    
    var helloBtnHideAndShow = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileName.text = nameSave
        if (imageSave ?? "") == "" {
            profileImageView.image = UIImage(named: "user")
        } else{
            profileImageView.sd_setImage(with: URL(string: imageUrl + (nameSave ?? "")) , completed: nil)
        }
//        profileImageView.image = imageSave
        userName.text = nameSave
        chatRequestMsgView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        chatRequestView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMinYCorner]
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
        hideandShowView()
        
    }
    
    func hideandShowView() {
        let vc = ProfileDetailsViewController()
        let chatVC = ChatViewController()
        let chatrequestVC = ChatsRequestsViewController()
        
        if chateBtnHideShow == vc.chathideAndShow
        {
            chatRequestTableView.isHidden = true
            msgTxtFieldView.isHidden = true
        }
//        else if msgBtnHideAndShow == vc.msgBtnHideAndShow
//        {
//            sayHelloView.isHidden = true
//            msgTxtFieldView.isHidden = true
//            chatRequestTableView.isHidden = false
//            chatRequestView.isHidden = false
//            chatRequestMsgView.isHidden = true
//        }
        else if chatTap == chatVC.chatTap || profileDetailTap == vc.acceptButtonHideAndShow {
            getMsgs()
            chatRequestView.isHidden = true
            chatRequestMsgView.isHidden = true
            msgTxtFieldView.isHidden = false
        }
        else if acceptBtnHideAndShow == chatrequestVC.acceeptBtnHideAndShow
        {
            chatRequestView.isHidden = true
            chatRequestMsgView.isHidden = true
        }
    }

    @IBAction func helloButtonAction(_ sender: UIButton) {
        addFriendRequestApi()
    }
    
    func addFriendRequestApi(){
        let param = ["other_user_uuid" : "\(other_user_uuid ?? "")"] as [String:Any] as [String:AnyObject]
        
        NetworkManager.AddFriendRequestApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    self.view.makeToast(data?["message"] as Any as? String ?? "")
                }
            }
            else {
                self.view.makeToast( (data?["message"] as? String) ?? "")
                self.view.endEditing(true)
                self.sendMessage(message: "Hello")
                self.sayHelloView.isHidden = true
                self.msgTxtFieldView.isHidden = true
                self.chatRequestTableView.isHidden = false
                self.chatRequestView.isHidden = true
                self.getMsgs()
            }
        }
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func menuButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController()
        let report = UIAlertAction(title: "Report this user", style: .default) { (Action) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportUserVC") as! ReportUserViewController
            vc.other_user_uuid = self.other_user_uuid
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let unfriend = UIAlertAction(title: "Unfriend", style: .default) { (Action) in
            self.RemoveFriendApi()
        }
        let cencel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        report.setValue(UIColor.black, forKey: "titleTextColor")
        cencel.setValue(UIColor.black, forKey: "titleTextColor")
        unfriend.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(cencel)
        alert.addAction(unfriend)
        alert.addAction(report)
        self.present(alert, animated: true)
    }
    //Remove Friend API
    func RemoveFriendApi(){
        let param = ["friend_uuid" : "\(friend_uuid ?? "")"] as [String:Any] as [String:AnyObject]
        print(param)
        NetworkManager.RemoveFriendApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    self.view.makeToast(data?["message"] as? String ?? "")
                }
                //refreshToken()
            }
            else {
                self.view.makeToast( (data?["message"] as? String) ?? "")
                self.view.endEditing(true)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func friendRequestAcceptOrRejectAction(_ sender: UIButton) {
        selectedButton = sender.tag
        if selectedButton == 0{
            //reject
            self.addFriendRequestConfirmOrRejectApi()
        }
        else if selectedButton == 1 {
            // accept
            self.addFriendRequestConfirmOrRejectApi()
        }
    }
    
    func addFriendRequestConfirmOrRejectApi() {
        let param = ["status" : "\(selectedButton ?? 0)", "request_uuid" : "\(request_uuid ?? "")"] as [String: Any] as [String:AnyObject]
        NetworkManager.AddFriendRequestConfirmOrRejectApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
            }
            else {
                self.view.window?.makeToast(data?["message"] as Any as? String ?? "")
                if self.selectedButton == 1 {
                    self.chatRequestView.isHidden = true
                    self.chatRequestMsgView.isHidden = true
                    self.msgTxtFieldView.isHidden = false
                }else if self.selectedButton == 0 {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                self.conversationTableView.reloadData()
            }
        }
    }
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        guard let msg = msgSendTextField.text else {
            return
        }
        sendMessage(message: msg)
    }
    
    func sendMessage(message: String){
        msgSendTextField.endEditing(true)
        msgSendTextField.isEnabled = false
        sendBtn.isEnabled = false
        let date = Date()
        let dateString = date.getFormattedDate(format: "hh:mm a")
        print(dateString)
        let msgDisc = [
            "isseen": 0,
            "msg": message,
            "receiver": (friend_uuid ?? ""),
            "sender" : (userDetail?.uuid ?? ""),
            "timeStamp" : dateString
        ] as Any as! [String : AnyObject]
        print(msgDisc)

        let msgDB = Database.database().reference().child("Chats").child(userDetail?.uuid ?? "").child(friend_uuid ?? "")
        msgDB.childByAutoId().setValue(msgDisc){(error,ref) in
            if(error != nil){
                debugPrint(error?.localizedDescription as Any)
            }else{
                debugPrint("Msg saved successfully")
                self.msgSendTextField.isEnabled = true
                self.sendBtn.isEnabled = true
                self.msgSendTextField.text = nil
            }
        }
        let msgDB2 = Database.database().reference().child("Chats").child(friend_uuid ?? "").child(userDetail?.uuid ?? "")
        msgDB2.childByAutoId().setValue(msgDisc){(error,ref) in
            if(error != nil){
                debugPrint(error?.localizedDescription as Any)
            }else{
                debugPrint("Msg saved successfully")
            }
        }
    }
    
    func getMsgs()
    {
        print(userDetail?.uuid ?? "")
        self.messageArray = []
        let msgDB = Database.database().reference().child("Chats").child(userDetail?.uuid ?? "").child(friend_uuid ?? "")
        msgDB.observe(.childAdded) { snapshot in
            print(snapshot)
            if let value = snapshot.value as? [String: AnyObject] {
                print(value as Any)
                let msg = Message(dictionary: value)
                self.messageArray.append(msg)
                self.conversationTableView.reloadData()
                self.scrollToBottom()
            }else {
                print(snapshot)
            }
        }
        let msgDB2 = Database.database().reference().child("Chats").child(friend_uuid ?? "").child(userDetail?.uuid ?? "")
        msgDB2.queryOrderedByKey().queryLimited(toLast: 1).observe(.childAdded)  { (snapshot) in
            if let value = snapshot.value as? [String: AnyObject] {
                print(value as Any)
                var newValue = value
                newValue["isseen"] = 1 as AnyObject
                if (value["sender"] as? String) != userDetail?.uuid ?? "" {
                    msgDB2.child(snapshot.key).updateChildValues(newValue) { (error, data) in
                    }
                }
            }else {
                print(snapshot)
            }
        }
    }
    
    func scrollToBottom() {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                let numberOfSections = self.conversationTableView.numberOfSections
                let numberOfRows = self.conversationTableView.numberOfRows(inSection: numberOfSections-1)
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.conversationTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: false)
                }
            }
        }
}

extension ChattingViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageArray[indexPath.row]
        if (userDetail?.uuid == message.sender) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as! SenderTableViewCell
            cell.configure(message: message)
            if (messageArray.count-1) == indexPath.row {
                cell.deliveredTextLabel.text = message.isseen == 1 ? "Seen" : "Delivered"
            } else{
                cell.deliveredTextLabel.text = ""
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as! ReceiverCell
            cell.configure(message: message)
            return cell
        }
    }
}

