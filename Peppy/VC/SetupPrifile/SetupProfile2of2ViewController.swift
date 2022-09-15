//
//  SetupProfileViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 06/07/21.
//

import UIKit
import PopupDialog
import Toast_Swift
import TagListView

class SetupProfile2of2ViewController: UIViewController {
    
    @IBOutlet weak var interestTagListView: TagListView!
    @IBOutlet weak var aboutMeTxtField: UITextView!
    @IBOutlet weak var occupationTxtField: UITextField!
    
    var addUserProfile: UserDetail?
    var selectedButton = 0
    var data : [String] = []
    var childrenAge:[String] = []
    var imageArray: [UIImage] = []
    var imgsData: [Data] = []
    var interestIDArr : [String] = []
    var interestNameArr:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagListViewDesign()
    }
    
    func addUserProfileApi() {
        self.view.endEditing(true)
        if aboutMeTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter About me")
            return
        }
        if occupationTxtField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            self.view.makeToast("Please Enter Occupation")
            return
        }
        if interestIDArr.count == 0 {
            self.view.makeToast("Please Select Interests")
            return
        }
        print(addUserProfile?.display_name ?? "", addUserProfile?.date_of_birth ?? "", addUserProfile?.no_of_children ?? "")
        let param = [
            "display_name" : addUserProfile?.display_name ?? "",
            "date_of_birth" : addUserProfile?.date_of_birth ?? "",
            "address" : addUserProfile?.address ?? "",
            "no_of_children" : addUserProfile?.no_of_children ?? "",
            "children_age_show" : "\(selectedButton)",
            "children_age" : "\(childrenAge.joined(separator: ","))",
            "interests" : "\(interestIDArr.joined(separator: ","))",
            "about_me" : aboutMeTxtField.text ?? "",
            "occupation" : occupationTxtField.text ?? ""
        ] as [String : Any] as [String:AnyObject]
        print(param)
        for i in imageArray{
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
                    let addUserMessage = data?["message"] as? String
                    self.view.makeToast(addUserMessage)
                }
                //refreshToken()
            }
            else {
                appDelegate.window?.rootViewController?.view.makeToast(data?["message"] as? String)
                let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePreviewViewController") as! ProfilePreviewViewController
                self.navigationController?.pushViewController(newVC, animated:true)
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        addUserProfileApi()
        
    }
    
    @IBAction func skipBtnAction(_ sender: Any) {
        addUserProfileApi()
    
    }
    func tagListViewDesign() {
        interestTagListView.delegate = self
        //        tagListView.textFont = UIFont.systemFont(ofSize: 20)
        var tagViewArray: [TagView] = []
        for i in allInterests {
            let tagView = interestTagListView.addTag(i.interest_name ?? "" )
            for j in interests {
                if i.interest_name == j.interest {
                    data.append(i.interest_name ?? "")
                    interestIDArr.append(i.uuid ?? "")
                    tagView.isSelected = true
                }
            }
            tagViewArray.append(tagView)
        }
        interestTagListView.removeAllTags()
        interestTagListView.addTagViews(tagViewArray)
     
    }
}

//MARK: - TagListView Delegate Method

extension SetupProfile2of2ViewController : TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        tagView.isSelected = !tagView.isSelected
        if !data.contains(title){
            data.append(title)
            for i in allInterests {
                if i.interest_name == title {
                    interestIDArr.append(i.uuid ?? "")
                    break
                }
            }
        }
        else {
            let index = data.firstIndex(of: title) ?? 0
            data.remove(at: index)
            interestIDArr.remove(at: index)
        }
        print(data)
        print(interestIDArr)
    }
}
