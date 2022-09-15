//
//  FavoritesViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var selectedButton = 0
    var friend_uuid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetFavoriteFriendApi()
    }
    
    
    @IBAction func notificationBtnAction(_ sender: Any) {
        let notificationVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    func GetFavoriteFriendApi() {
        NetworkManager.GetFavouriteFriendApi(param: [:]) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                getFavoriteFriend = GetFriend.modelsFromDictionaryArray(array: data?["Data"] as Any as? NSArray ?? [])
                
                print(data?["Data"] as Any as? NSArray ?? [])
                self.favoriteTableView.reloadData()
            }
        }
    }
    
    func AddOrRemoveFavouriteFriendApi() {
        let param = ["status" : "\(selectedButton)", "friend_uuid" : "\(friend_uuid ?? "")"] as [String: Any] as [String:AnyObject]
        print(param)
        NetworkManager.AddOrRemoveFavouriteFriendApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                self.view.window?.makeToast(data?["message"] as Any as? String ?? "")
                self.favoriteTableView.reloadData()
                self.GetFavoriteFriendApi()
            }
        }
    }

    @objc func favouriteBtnAction(_ sender: UIButton) {
        selectedButton = sender.tag
        print(selectedButton)
        sender.isSelected = !sender.isSelected
        self.AddOrRemoveFavouriteFriendApi()
    }
}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getFavoriteFriend.count == 0{
            tableView.setEmptyMessage("Data Not Found!..")
        } else {
            tableView.restore()
        }
        return getFavoriteFriend.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = getFavoriteFriend[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
        cell.personNameLabel.text = model.friend_name
        self.friend_uuid = model.friend_uuid
        if (model.friend_profile ?? "") == "" {
            cell.profileImage.image = UIImage(named: "user")
        } else{
            cell.profileImage.sd_setImage(with: URL(string: imageUrl + (model.friend_profile ?? "")) , completed: nil)
        }
        cell.favouriteBtn.addTarget(self, action: #selector(favouriteBtnAction(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = getFavoriteFriend[indexPath.row]
        let profileDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailsViewController") as! ProfileDetailsViewController
        profileDetailVC.other_user_uuid = model.friend_uuid
        navigationController?.pushViewController(profileDetailVC, animated: true)
    }
}
