//
//  EditProfileViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 05/07/21.
//

import UIKit
import SDWebImage

class EditProfileViewController: UIViewController {
    
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
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var occupationsTextField: UITextField!
    
    var datePicker = UIDatePicker()
    var imageArray: [UIImage] = []
    var NewImageArray: [UIImage] = []
//    var imageArray: [UIImage] = []
    var isEdit: Bool?
    var selectedIndex : Int?
    var addUserProfile: AddUserProfile?
    var selectedButton = 0
    var childrenAge:[String] = []
    var imgsData:[Data] = []
    var interestID : [String] = []
    var profileImageArr: [String] = []
    var no_of_children: String = ""
    var oldUrl: [Int:String?] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDatePicker()
        deleteButton1.isHidden = true
        deleteButton2.isHidden = true
        deleteButton3.isHidden = true
        deleteButton4.isHidden = true
        getEditProfileData()
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func getEditProfileData(){
        nameTextField.text = userDetail?.name
        emailTextField.text = userDetail?.email
        displayNameTextField.text = userDetail?.display_name
        dateOfBirthTextField.text = userDetail?.date_of_birth
        addressTextField.text = userDetail?.address
        aboutMeTextView.text = userDetail?.about_me
        occupationsTextField.text = userDetail?.occupation
        interestID = []
        for i in userDetail?.interests ?? [] {
            interestID.append(i.interest_uuid ?? "")
        }
        
        no_of_children = "\(userDetail?.children?.count ?? 0)"
        for i in userDetail?.children ?? [] {
            childrenAge.append(i.age ?? "0")
        }
        selectedButton = userDetail?.children_age_show ?? 0
        
        for i in 0...3 {
            if i < (userDetail?.pictures?.count ?? 0){
                let imageView = UIImageView()
                //imageView.sd_setImage(with: URL(string: imageUrl + (userDetail?.pictures?[i].path ?? "")), placeholderImage: UIImage(named: "noImage"), options: .highPriority, context: nil)
                self.imageArray.append(UIImage())
                imageView.sd_setImage(with: URL(string: imageUrl + (userDetail?.pictures?[i].path ?? ""))) { (img, error, s, url) in
                    self.imageArray.remove(at: i)
                    self.imageArray.insert(img ?? UIImage(), at: i)
                    if self.imageArray.count > 3 {
                        self.imageManage()
                    }
                }
                
            } else {
                self.imageArray.append(UIImage())
            }
        }
        for (indx,i) in (userDetail?.pictures ?? []).enumerated() {
            oldUrl[indx] = i.uuid
        }
        
        imageManage()
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
        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
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
        if sender == deleteButton1 {
            for (indx,i) in NewImageArray.enumerated() {
                if i == imageArray[0] {
                    self.NewImageArray.remove(at: indx)
                    break
                }
            }
            imageArray.remove(at: 0)
            imageArray.insert(UIImage(), at: 0)
            if oldUrl[0] != nil {
                oldUrl[0] = nil
            }
        }
        else if sender ==  deleteButton2 {
            for (indx,i) in NewImageArray.enumerated() {
                if i == imageArray[1] {
                    self.NewImageArray.remove(at: indx)
                    break
                }
            }
            imageArray.remove(at: 1)
            imageArray.insert(UIImage(), at: 1)
            if oldUrl[1] != nil {
                oldUrl[1] = nil
            }
        }
        else if sender == deleteButton3
        {
            for (indx,i) in NewImageArray.enumerated() {
                if i == imageArray[2] {
                    self.NewImageArray.remove(at: indx)
                    break
                }
            }
            imageArray.remove(at: 2)
            imageArray.insert(UIImage(), at: 2)
            if oldUrl[2] != nil {
                oldUrl[2] = nil
            }
        }
        else if sender == deleteButton4
        {
            for (indx,i) in NewImageArray.enumerated() {
                if i == imageArray[3] {
                    self.NewImageArray.remove(at: indx)
                    break
                }
            }
            imageArray.remove(at: 3)
            imageArray.insert(UIImage(), at: 3)
            if oldUrl[3] != nil {
                oldUrl[3] = nil
            }
        }
        imageManage()
    }
    
    @IBAction func interestBtnAction(_ sender: Any) {
        let interestVC = self.storyboard?.instantiateViewController(withIdentifier: "InterestViewController") as! InterestViewController
        interestVC.completion = { tag in
            self.interestID = tag
        }
        navigationController?.pushViewController(interestVC, animated: true)
    }
    
    @IBAction func childrenDetailBtnAction(_ sender: Any) {
        let childrenDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ChildrenDetailViewController") as! ChildrenDetailViewController
        childrenDetailsVC.completion = { selectBtn, childrenAge, numberOfChildren in
            self.selectedButton = selectBtn
            self.childrenAge = childrenAge
            self.no_of_children = numberOfChildren
        }
        navigationController?.pushViewController(childrenDetailsVC, animated: true)
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        print(imageArray.count)
        addUserProfileApi()
    }
    
    func addUserProfileApi() {
        self.view.endEditing(true)
        if imageArray.count == 0 {
            if oldUrl.count == 0 {
                self.view.makeToast("Images Required")
                return
            }
        }
//        if nameTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.view.makeToast("Please Enter Your Name")
//            return
//        }
        if displayNameTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Display Name")
            return
        }
        if dateOfBirthTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Date of Birth")
            return
        }
        if addressTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Address")
            return
        }
        if aboutMeTextView.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter About me")
            return
        }
        if occupationsTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Occupation")
            return
        }
        if interestID.count == 0 {
            self.view.makeToast("Please Select Interests")
            return
        }
        if no_of_children.isEmpty == true {
            self.view.makeToast("Please Enter No Of Children")
            return
        }
        if childrenAge.count == 0 {
            self.view.makeToast("Please Enter age of children")
            return
        }
        var oldPic: [String] = []
        for i in oldUrl {
            if i.value != nil {
                oldPic.append(i.value ?? "")
            }
        }
        imgsData = []
        
        let param = [/*"name" : nameTextField.text ?? "",*/
            "display_name" : displayNameTextField.text ?? "",
            "date_of_birth" : dateOfBirthTextField.text ?? "",
            "address" : addressTextField.text ?? "",
            "no_of_children" : no_of_children ,
            "children_age_show" : "\(selectedButton)",
            "children_age" : "\(childrenAge.joined(separator: ","))",
            "interests" : "\(interestID.joined(separator: ","))",
            "about_me" : aboutMeTextView.text ?? "",
            "occupation" : occupationsTextField.text ?? "",
            "oldpic" : oldPic.joined(separator: ",")
        ] as [String : Any] as [String:AnyObject]
        print(param)
        
        for i in NewImageArray{
            if ((i.ciImage != nil) || (i.cgImage != nil)) {
                let imageData = i.jpegData(compressionQuality: 0.75)
                imgsData.append(imageData!)
            }
        }
        
        NetworkManager.profileImageApi(param: param, imgsData: imgsData) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    self.view.makeToast(data?["Message"] as? String)
                }
                //refreshToken()
            }
            else {
                self.view.makeToast(data?["Message"] as? String ?? "User Data Edited Successfully")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageArray.remove(at: selectedIndex ?? 0)
            imageArray.insert(image, at: selectedIndex ?? 0)
            NewImageArray.append(image)
            self.imageManage()
        }
        dismiss(animated: true, completion: nil)
    }
}
