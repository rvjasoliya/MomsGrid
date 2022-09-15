//
//  ChangePasswordViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 10/07/21.
//

import UIKit
import Toast_Swift

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var currentPasswordShowBtn: UIButton!
    @IBOutlet weak var currentPasswordTxtField: UITextField!
    @IBOutlet weak var newPasswordShowBtn: UIButton!
    @IBOutlet weak var newPasswordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordShowBtn: UIButton!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func currentPasswordShowBtnAction(_ sender: Any) {
        if currentPasswordTxtField.isSecureTextEntry {
            currentPasswordShowBtn.setTitle("Hide", for: .normal)
            currentPasswordTxtField.isSecureTextEntry = false
        }
        else {
            currentPasswordShowBtn.setTitle("Show", for: .normal)
            currentPasswordTxtField.isSecureTextEntry = true
        }
    }
    
    @IBAction func newPasswordShowBtnAction(_ sender: Any) {
        if newPasswordTxtField.isSecureTextEntry {
            newPasswordShowBtn.setTitle("Hide", for: .normal)
            newPasswordTxtField.isSecureTextEntry = false
        }
        else {
            newPasswordShowBtn.setTitle("Show", for: .normal)
            newPasswordTxtField.isSecureTextEntry = true
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
    @IBAction func saveBtnAction(_ sender: Any) {
        if currentPasswordTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Current Password")
            return
        }
        if newPasswordTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter New Password")
            return
        }
        if confirmPasswordTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Confirm Password")
            return
        }
        if newPasswordTxtField.text != confirmPasswordTxtField.text {
            self.view.makeToast("Your New Password and confirm Password not match")
            return
        }
        let param = ["oldpassword": currentPasswordTxtField.text ?? "","newpassword":newPasswordTxtField.text ?? "", "confpassword":confirmPasswordTxtField.text ?? ""] as [String:Any] as [String:AnyObject]

            NetworkManager.changePasswordApi(param: param) { status, data, error in
                if !status {
                    if error != nil {
                        print(error?.localizedDescription as Any)
                    } else {
                        let changePasswordMessage = data?["message"] as? String
                        self.view.makeToast(changePasswordMessage)
                    }
                }
                else {
                    let changePasswordMessage = data?["message"] as? String
                    self.view.makeToast(changePasswordMessage)
                    self.navigationController?.popViewController(animated: true)
                }
            }
       
    }
}
