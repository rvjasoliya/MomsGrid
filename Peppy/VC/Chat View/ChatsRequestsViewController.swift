//
//  ChatsRequestsViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class ChatsRequestsViewController: UIViewController {

    @IBOutlet weak var chatRequestTableView: UITableView!
    
    var acceeptBtnHideAndShow = true
    var hideAndShow = true
    var selectedButton = 0
    var request_uuid: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        chatRequestTableView.delegate = self
        chatRequestTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetFriendRequestApi()
    }

    func GetFriendRequestApi() {
        NetworkManager.GetFriendRequestApi(param: [:]) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                getFriendRequest = GetFriendRequest.modelsFromDictionaryArray(array: data?["Data"] as Any as? NSArray ?? [])
                self.chatRequestTableView.reloadData()
            }
        }
    }
    
    func addFriendRequestConfirmOrRejectApi() {
        let param = ["status" : "\(selectedButton)", "request_uuid" : "\(request_uuid ?? "")"] as [String: Any] as [String:AnyObject]
        NetworkManager.AddFriendRequestConfirmOrRejectApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                self.view.window?.makeToast(data?["message"] as Any as? String ?? "")
                self.GetFriendRequestApi()
            }
        }
    }
}

extension ChatsRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getFriendRequest.count == 0{
            tableView.setEmptyMessage("Data Not Found!..")
        } else {
            tableView.restore()
        }
        return getFriendRequest.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = getFriendRequest[indexPath.row]
        let user_Interest:[Interests] = getFriendRequest[indexPath.row].user_Interest ?? []
        let  cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatRequestsTableViewCell
        cell.personName.text = model.user_name
        var interestName = ""
        for i in user_Interest {
            interestName = interestName == "" ? (i.interest ?? "") :  (interestName + ", " + (i.interest ?? ""))
        }
        cell.messageLabel.text = interestName
        self.request_uuid = model.request_uuid
        if (model.profile ?? "") == "" {
            cell.profileImageView.image = UIImage(named: "user")
        } else{
            cell.profileImageView.sd_setImage(with: URL(string: imageUrl + (model.profile ?? "")) , completed: nil)
        }
        cell.acceptButton.addTarget(self, action: #selector(acceptOrRejectButtonAction(_:)), for: .touchUpInside)
        cell.rejectButton.addTarget(self, action: #selector(acceptOrRejectButtonAction(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = getFriendRequest[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailsViewController") as! ProfileDetailsViewController
        vc.hideAndShow = hideAndShow
        vc.request_uuid = model.request_uuid
        vc.other_user_uuid = model.user_uuid
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func acceptOrRejectButtonAction(_ sender: UIButton){
        selectedButton = sender.tag
        if selectedButton == 0 {
            //reject
            self.addFriendRequestConfirmOrRejectApi()
        }
        else if selectedButton == 1 {
            // accept
            self.addFriendRequestConfirmOrRejectApi()
        }
    }
}
