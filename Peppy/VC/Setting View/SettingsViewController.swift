//
//  SettingsViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit
import PopupDialog

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var titleLabelArray : [String] = ["About Us","Terms & Condition","Privacy Policy","Contact Admin","Change Password","FAQ","Logout"]
    var iconNameArray : [String] = ["ic_about-us","ic_t&c","ic_privacy_policy","ic_contact-admin","ic_only-me","ic_faq","ic_logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.allowsSelection = true
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func logoutAlertPopup(){
        alertDesign()
        let title = "Logout"
        let message = "Are you sure you want to logout ?"
        let popup = PopupDialog(title: title, message: message,buttonAlignment: .horizontal)
        let OkBtn = DefaultButton(title: "Logout", height: 50) {
            self.userLogoutApi()
        }
        let Cancel = CancelButton(title: "Cancel", height: 50) {
            self.dismiss(animated: true, completion: nil)
        }
        OkBtn.backgroundColor = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1)
        OkBtn.titleColor = UIColor.white
        Cancel.titleColor = .darkGray
        OkBtn.titleFont = UIFont(name: "Avenir Next Demi Bold", size: 17)
        Cancel.titleFont = UIFont(name: "Avenir Next Demi Bold", size: 17)
        popup.addButtons([Cancel, OkBtn])
        self.present(popup, animated: true, completion: nil)
    }
    
    private func alertDesign() {
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont    = UIFont(name: "Avenir Next Medium", size: 20)!
        pv.titleColor   = .black
        pv.messageFont  = UIFont(name: "Avenir Next Regular", size: 17)!
        pv.messageColor = UIColor.black
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = 10
    }
    
    func userLogoutApi() {
        
        NetworkManager.logoutApi(param: [:]) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    self.view.window?.makeToast(data?["message"] as? String)
                }
            }
            else {
                userDefaults.removeObject(forKey: "accessToken")
                self.view.window?.makeToast(data?["message"] as? String ?? "User Logout Successfully!..")
                let newVC = self.storyboard?.instantiateViewController(withIdentifier: "loginNav") as! UINavigationController
                appDelegate.window?.rootViewController = newVC
            }
        }
    }
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastIndex = (self.titleLabelArray.count) - 1
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SettingsTableViewCell
        cell.titleLabel.text = titleLabelArray[indexPath.row]
        cell.iconImageView.image = UIImage(named: iconNameArray[indexPath.row])
        if indexPath.row == lastIndex {
            cell.detailsIndicator.isHidden = true
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellText = settingsTableView.cellForRow(at: indexPath) as! SettingsTableViewCell
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as! webViewController
            vc.titleLabel = cellText.titleLabel.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as! webViewController
            vc.titleLabel = cellText.titleLabel.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as! webViewController
            vc.titleLabel = cellText.titleLabel.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactAdminVC") as! ContactAdminViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 4 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 5 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FaqVC") as! FaqViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 6 {
            logoutAlertPopup()
        }
    }
}

