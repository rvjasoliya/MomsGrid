//
//  SetupProfile1of2ViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit


class SetupProfile1of2ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var profileImg1: UIImageView!
    @IBOutlet weak var profileImg2: UIImageView!
    @IBOutlet weak var profileImg3: UIImageView!
    @IBOutlet weak var profileImg4: UIImageView!
    
    @IBOutlet weak var imageButton1 : UIButton!
    @IBOutlet weak var imageButton2: UIButton!
    @IBOutlet weak var imageButton3: UIButton!
    @IBOutlet weak var imageButton4: UIButton!
    
    @IBOutlet weak var deleteButton1: UIButton!
    @IBOutlet weak var deleteButton2: UIButton!
    @IBOutlet weak var deleteButton3: UIButton!
    @IBOutlet weak var deleteButton4: UIButton!
    
    @IBOutlet weak var visiblityBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var displayNameTxtField: UITextField!
    @IBOutlet weak var dateOfBirthTxtField: UITextField!
    @IBOutlet weak var noOfChildrenTxtField: UITextField!
    @IBOutlet weak var profileAddressTxtField: UITextField!
    @IBOutlet weak var childrenTableview: UITableView!
    @IBOutlet weak var childenListHeight: NSLayoutConstraint!
    
    var selectedButton = 2
    var childrenAge:[String] = []
    weak var activeImageView:UIImageView? = nil
    var imageArray: [UIImage] = []
    let datePicker = UIDatePicker()
    var selectedIndex : Int?
    
    var firstTimeSetup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        childrenTableview.delegate = self
        childrenTableview.dataSource = self
        noOfChildrenTxtField.delegate = self
        deleteButton1.isHidden = true
        deleteButton2.isHidden = true
        deleteButton3.isHidden = true
        deleteButton4.isHidden = true
        childenListHeight.constant = 0
        backBtn.isHidden = firstTimeSetup
        
        for _ in 1...4 {
            imageArray.append (UIImage())
        }
    }
    
    func setDatePicker(){
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.maximumDate = Date()
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateOfBirthTxtField.inputAccessoryView = toolbar
        dateOfBirthTxtField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateOfBirthTxtField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let count = Int(textField.text ?? "") ?? 0
        setValueChildren(count: count)
    }
    
    func setValueChildren(count: Int) {
        childrenAge.removeAll()
        for _ in 0..<count {
            childrenAge.append("")
        }
        childenListHeight.constant = CGFloat(childrenAge.count*100)
        childrenTableview.reloadData()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageArray.remove(at: selectedIndex ?? 0)
            imageArray.insert(image, at: selectedIndex ?? 0)
            self.imageManage()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addUserProfileApi() {
        if imageArray.count == 0 {
            self.view.makeToast("Image required")
            return
        }
        if displayNameTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Display Name")
            return
        }
        if dateOfBirthTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Date of Birth")
            return
        }
        if profileAddressTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Address")
            return
        }
        if noOfChildrenTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter No Of Children")
            return
        }
        if childrenAge.count == 0 {
            self.view.makeToast("Please Enter age of children")
            return
        }
        if childrenAge.contains("") {
            self.view.makeToast("Please Enter age of children")
            return
        }
        
        let model = UserDetail(display_name: displayNameTxtField.text, date_of_birth: dateOfBirthTxtField.text, address: profileAddressTxtField.text, no_of_children: "\(childrenAge.count)")
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SetupProfile2of2ViewController") as! SetupProfile2of2ViewController
        newVC.addUserProfile = model
        newVC.selectedButton = selectedButton
        newVC.childrenAge = childrenAge
        newVC.imageArray = imageArray
        navigationController?.pushViewController(newVC, animated:true)
    }
    
    func imageManage() {
        
        deleteButton1.isHidden = ((imageArray[0].ciImage != nil) || (imageArray[0].cgImage != nil)) ?  false : true
        deleteButton2.isHidden = ((imageArray[1].ciImage != nil) || (imageArray[1].cgImage != nil)) ?  false : true
        deleteButton3.isHidden = ((imageArray[2].ciImage != nil) || (imageArray[2].cgImage != nil)) ?  false : true
        deleteButton4.isHidden = ((imageArray[3].ciImage != nil) || (imageArray[3].cgImage != nil)) ?  false : true
        
        self.view.viewWithTag(1001)?.isHidden = !((imageArray[0].ciImage != nil) || (imageArray[0].cgImage != nil)) ?  false : true
        self.view.viewWithTag(1002)?.isHidden = !((imageArray[1].ciImage != nil) || (imageArray[1].cgImage != nil)) ?  false : true
        self.view.viewWithTag(1003)?.isHidden = !((imageArray[2].ciImage != nil) || (imageArray[2].cgImage != nil)) ?  false : true
        self.view.viewWithTag(1004)?.isHidden = !((imageArray[3].ciImage != nil) || (imageArray[3].cgImage != nil)) ?  false : true
        
        profileImg1.image = imageArray[0]
        profileImg2.image = imageArray[1]
        profileImg3.image = imageArray[2]
        profileImg4.image = imageArray[3]
    }
    
    @IBAction func imageButtonsAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender == imageButton1
        {
            selectedIndex = 0
        }
        else if sender == imageButton2 {
            selectedIndex = 1
        }
        else if sender == imageButton3
        {
            selectedIndex = 2
        }
        else if sender == imageButton4
        {
            selectedIndex = 3
        }
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    @IBAction func deleteButtonsAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender == deleteButton1 {
            imageArray.remove(at: 0)
            imageArray.insert(UIImage(), at: 0)
        }
        else if sender ==  deleteButton2 {
            imageArray.remove(at: 1)
            imageArray.insert(UIImage(), at: 1)
        }
        else if sender == deleteButton3
        {
            imageArray.remove(at: 2)
            imageArray.insert(UIImage(), at: 2)
        }
        else if sender == deleteButton4
        {
            imageArray.remove(at: 3)
            imageArray.insert(UIImage(), at: 3)
        }
        imageManage()
        
    }

    @IBAction func backBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func visibilityBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        let visiblityVC = self.storyboard?.instantiateViewController(withIdentifier: "VisibilityViewController") as! VisibilityViewController
        visiblityVC.completion = { tag in
            self.selectedButton = tag
            self.visiblityBtn.setTitle(tag == 0 ? "Public" : tag == 1 ? "Friends" : "Only Me", for: .normal)
        }
        visiblityVC.selectedButton = selectedButton
        navigationController?.pushViewController(visiblityVC, animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        addUserProfileApi()
    }
}

extension SetupProfile1of2ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenAge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildrenTableViewCell", for: indexPath) as! ChildrenTableViewCell

        cell.completionBlock = { data in
            self.childrenAge.remove(at: indexPath.row)
            self.childrenAge.insert(data ?? "", at: indexPath.row)
            tableView.reloadData()
        }
        cell.childrenAgeLabel.text = "Children \(indexPath.row) Age :"
        return cell
    }
}
