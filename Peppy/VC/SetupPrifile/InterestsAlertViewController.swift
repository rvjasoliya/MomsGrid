//
//  InterestsAlertViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 06/07/21.
//

import UIKit

protocol addInterestDelegate {
    func addInterest(interest: Interests)
}

class InterestsAlertViewController: UIViewController{
    
    @IBOutlet weak var addInterestsTxtField: UITextField!
    
    var delegate: addInterestDelegate?
    var interestPicker = UIPickerView()
    var interestArray = [Interests]()
    var interestID : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interestPicker.delegate = self
        interestPicker.dataSource = self
        addInterestsTxtField.delegate = self
        addInterestsTxtField.inputView = interestPicker

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        for i in allInterests {
            var isAddeed = false
            for j in interests {
                if j.interest == i.interest_name {
                    isAddeed = true
                    break
                }
            }
            print(isAddeed)
            if !(isAddeed) {
                interestArray.append(i)
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        guard let interestName = addInterestsTxtField.text, addInterestsTxtField.hasText else {
            print("handle error")
            return  }
        
        let interestss = Interests(interest: interestName)
        delegate?.addInterest(interest: interestss)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK: - UITextfield Delegate

extension InterestsAlertViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
}


//MARK:- UIPickerView Delegate And DataSource Methods

extension InterestsAlertViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return interestArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return interestArray[row].interest_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addInterestsTxtField.text = interestArray[row].interest_name
        self.view.endEditing(true)
    }
    
    
}
