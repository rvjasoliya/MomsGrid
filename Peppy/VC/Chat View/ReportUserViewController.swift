//
//  ReportUserViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit
import PopupDialog

class ReportUserViewController: UIViewController {
    
    @IBOutlet weak var reportUserTextField: UITextField!
  
    var other_user_uuid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitButtonAction(_ sender: UIButton) {
        ReportUserApi()
      
    }
    private func alertPopUp(){
        alertDesign()
        let title = "User Reported"
        let message = "Thank you for reporting. Our team will look back to it soon."
        let popup = PopupDialog(title: title, message: message)
        let buttonOne = CancelButton(title: "Ok", height: 50)
        {
            self.navigationController?.popToRootViewController(animated: true)
        }
        buttonOne.backgroundColor = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1)
        buttonOne.titleColor = UIColor.white
        buttonOne.titleFont = UIFont(name: "Avenir Next Demi Bold", size: 17)
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    private func alertDesign() {
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont = UIFont(name: "Avenir Next Medium", size: 20)!
        pv.titleColor = .black
        pv.messageFont = UIFont(name: "Avenir Next Regular", size: 17)!
        pv.messageColor = UIColor.black
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = 10
    }
    
    func ReportUserApi(){
        let param = ["other_user_uuid" : "\(other_user_uuid ?? "")", "reason" : "\(reportUserTextField.text ?? "")"] as [String:Any] as [String:AnyObject]
        print(param)
        NetworkManager.ReportUserApi(param: param) { status, data, error in
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
                self.alertPopUp()
            }
        }
    }

    
}

