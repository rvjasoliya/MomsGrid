//
//  InterestViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 08/07/21.
//

import UIKit
import PopupDialog
import TagListView

class InterestViewController: UIViewController {
    
    @IBOutlet weak var tagListView: TagListView!
    
    var data : [String] = []
    var interestIDArr: [String] = []
    var count = 0
    typealias CB = (_ tag: [String]) -> ()
    var completion:CB?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagListView.delegate = self
        //        tagListView.textFont = UIFont.systemFont(ofSize: 20)
        var tagViewArray: [TagView] = []
        for i in allInterests {
            let tagView = tagListView.addTag(i.interest_name ?? "" )
            for j in interests {
                if i.interest_name == j.interest {
                    data.append(i.interest_name ?? "")
                    interestIDArr.append(i.uuid ?? "")
                    tagView.isSelected = true
                }
            }
            tagViewArray.append(tagView)
        }
        tagListView.removeAllTags()
        tagListView.addTagViews(tagViewArray)
    
        print(data)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        guard let cb = completion else {
            return
        }
        cb(interestIDArr)
        navigationController?.popViewController(animated: true)
    }
}


extension InterestViewController : TagListViewDelegate {
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
    }
}
