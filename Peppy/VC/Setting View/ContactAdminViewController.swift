//
//  ContactAdminViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit
import PopupDialog

class ContactAdminViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        adminAlert()
        adminAlertDesign()
    }
    
    func adminAlert() {
        let message = "Thanks you for submitting your request. We will surely help You"
        let popup = PopupDialog( title: "", message: message)
        let buttonOne = CancelButton(title: "Ok", height: 50) {
            self.navigationController?.popViewController(animated: true)
        }
        buttonOne.backgroundColor = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1)
        buttonOne.titleColor = UIColor.white
        buttonOne.titleFont = UIFont(name: "Avenir Next Demi Bold", size: 17)
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    func adminAlertDesign() {
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.messageFont  = UIFont(name: "Avenir Next Regular", size: 17)!
        pv.messageColor = UIColor.black
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius    = 10
    }
}
