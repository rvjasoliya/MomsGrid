//
//  NotificationViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 02/07/21.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var notificationTableView: UITableView!
    
    var notificationImageArr = [""]
    var notifictionTitleArr = [""]
    var notificationDayArr = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        notificationImageArr = ["ic_user-img-1.png","ic_user-img.png","ic_user_img-8.png","ic_admiin_notification.png"]
        notifictionTitleArr = ["Hey, Ranveer sharma has sent you chat request.","Hey, Rajan Khana has accepted your chat request.","Samir Khana has sent you a message.","Admin, App has new features, update now to check."]
        notificationDayArr = ["Today 2:30 PM","12-Aug-2020 11:30 AM","Today 2:30 PM","Today 2:30 PM"]
        
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- TableView Delegate and DataSource Method
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notifictionTitleArr.count == 0{
            tableView.setEmptyMessage("Data Not Found!..")
        } else {
            tableView.restore()
        }
        return notifictionTitleArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as! NotificationTableViewCell
        cell.notificationImageView.image = UIImage(named: notificationImageArr[indexPath.row])
        cell.notificationTitleLabel.text = notifictionTitleArr[indexPath.row]
        cell.notificationDayLabel.text = notificationDayArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
