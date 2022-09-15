//
//  ForgotPasswordViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 01/07/21.
//

import UIKit
import PopupDialog
import Toast_Swift

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        forgotPasswordApi()
    }
    
    //MARK:- Forgot Password Alert
    
    func forgotPasswordAlert()
    {
        alertDesign()
        let title = "Forgot Password"
        let message = "A link to reset your password has been sent to your registered email account."
        let popup = PopupDialog(title: title, message: message)
        
        let buttonOne = CancelButton(title: "Ok", height: 50)
        {
            self.navigationController?.popViewController(animated: true)
        }
        
        buttonOne.backgroundColor = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1)
        buttonOne.titleColor = UIColor.white
        buttonOne.titleFont = UIFont(name: "Avenir Next Demi Bold", size: 17)
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    func alertDesign() {
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont = UIFont(name: "Avenir Next Medium", size: 20)!
        pv.titleColor = .black
        pv.messageFont = UIFont(name: "Avenir Next Regular", size: 17)!
        pv.messageColor = UIColor.black
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = 10
    }
    
    // MARK:- Forgot Password Api
    
    func forgotPasswordApi() {
        if emailTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter email")
            return
        }
        if isEmailValid(email: emailTxtField.text!) == false {
            self.view.makeToast("Please Enter Valid Email")
            return
        }
        let param = ["email":emailTxtField.text ?? ""] as [String:Any] as [String:AnyObject]
        NetworkManager.forgotPasswordApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                else {
                    if error != nil {
                        self.view.makeToast(error?.localizedDescription ?? "")
                    } else {
                        self.view.makeToast(data?["message"] as Any as? String ?? "")
                    }
                    self.view.makeToast("User Not Found")
                }
                //refreshToken()
            }
            else {
                self.forgotPasswordAlert()
            }
        }
    }
}
