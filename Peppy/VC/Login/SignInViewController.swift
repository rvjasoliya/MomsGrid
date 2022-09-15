//
//  LoginViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 01/07/21.
//

import UIKit
import Toast_Swift

class SignInViewController: UIViewController {
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordShowBtn: UIButton!
    
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
    
    @IBAction func signInBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        // MARK:- Login Validation
        
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
        
        // MARK:- login Api
        let param = ["email":emailTxtField.text ?? "","password":passwordTxtField.text ?? ""] as [String: Any] as [String:AnyObject]
        NetworkManager.loginApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    self.view.makeToast(error?.localizedDescription ?? "")
                } else {
                    self.view.makeToast(data?["message"] as Any as? String ?? "")
                }
            }
            else {
                self.view.makeToast( (data?["message"] as? String) ?? "User successfully login...")
                userDefaults.set(data?["Data"]?["access_token"] as Any as? String ?? "", forKey: "accessToken")
                userDefaults.synchronize()
                token = userDefaults.string(forKey: "accessToken") ?? ""
                let newVC = self.storyboard?.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
                appDelegate.window?.rootViewController = newVC
            }
        }
    }
    
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        let forgotPassVC = self.storyboard?.instantiateViewController(withIdentifier: "forgot password") as! ForgotPasswordViewController
        navigationController?.pushViewController(forgotPassVC, animated: true)
    }
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

