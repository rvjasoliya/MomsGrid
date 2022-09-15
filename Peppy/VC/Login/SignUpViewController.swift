//
//  ViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 01/07/21.
//

import UIKit
import PopupDialog
import Toast_Swift

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    @IBOutlet weak var passwordShowBtn: UIButton!
    @IBOutlet weak var confirmPasswordShowBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func passwordShowBtnAction(_ sender: Any) {
        if passwordTxtField.isSecureTextEntry {
            passwordShowBtn.setTitle("Hide", for: .normal)
            passwordTxtField.isSecureTextEntry = false
        }
        else {
            passwordShowBtn.setTitle("Show", for: .normal)
            passwordTxtField.isSecureTextEntry = true
        }
    }
    
    @IBAction func confirmPasswordShowBtnAction(_ sender: Any) {
        if confirmPasswordTxtField.isSecureTextEntry {
            confirmPasswordShowBtn.setTitle("Hide", for: .normal)
            confirmPasswordTxtField.isSecureTextEntry = false
        }
        else {
            confirmPasswordShowBtn.setTitle("Show", for: .normal)
            confirmPasswordTxtField.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        // MARK:- Register Validation
        
        if nameTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Name")
            return
        }
        if emailTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter email")
            return
        }
        if isEmailValid(email: emailTxtField.text!) == false {
            self.view.makeToast("Please Enter Valid Email")
            return
        }
        if passwordTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Password")
            return
        }
        if (passwordTxtField.text?.trimmingCharacters(in: .whitespaces).count ?? 0) < 6 {
            self.view.makeToast("The password must be at least 6 characters.")
            return
        }
        if confirmPasswordTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Confirm Password")
            return
        }
        if passwordTxtField.text != confirmPasswordTxtField.text {
            self.view.makeToast("Your Password and confirm Password not match")
            return
        }
        let param = [
            "name":nameTxtField.text ?? "",
            "email":emailTxtField.text ?? "",
            "password":passwordTxtField.text ?? "",
            "password_confirmation":confirmPasswordTxtField.text ?? ""
        ] as [String:Any] as [String:AnyObject]
        
        // Register Api
        NetworkManager.registerApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    if error != nil {
                        self.view.makeToast(error?.localizedDescription ?? "")
                    } else {
                        self.view.makeToast(data?["message"] as Any as? String ?? "")
                    }
                }
            }
            else {
                self.view.makeToast( (data?["message"] as? String) ?? "User successfully registered")
                self.registerAlert()
            }
        }
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    func registerAlert()
    {
        alertDesign()
        let title = "Register"
        let message = "An email with verification link is sent to your email account. Please verify to login."
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
    
}

