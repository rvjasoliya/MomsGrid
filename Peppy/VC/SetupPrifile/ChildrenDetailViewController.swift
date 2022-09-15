//
//  ChildrenDetailViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 08/07/21.
//

import UIKit

class ChildrenDetailViewController: UIViewController,  UITextFieldDelegate {
    
    @IBOutlet weak var visiblityBtn: UIButton!
    @IBOutlet weak var numberOfChildrenTextField: UITextField!
    @IBOutlet weak var childTableView: UITableView!
    
    var selectedButton = 2
    var childrenAge:[String] = []
    typealias CB = (_ selectBtn:Int,_ age: [String],_ numberOfChild: String) -> ()
    var completion:CB?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        childTableView.delegate = self
        childTableView.dataSource = self
        numberOfChildrenTextField.delegate = self
        numberOfChildrenTextField.text = "\(userDetail?.children?.count ?? 0)"
        setValueChildren(count: userDetail?.children?.count ?? 0)
        selectedButton = userDetail?.children_age_show ?? 2
        print(selectedButton)
        visiblityBtn.setTitle(selectedButton == 0 ? "Public" : selectedButton == 1 ? "Friends" : "Only Me", for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        childTableView.reloadData()
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
        childTableView.reloadData()
    }
    
    @IBAction func visiblityBtnAction(_ sender: Any)
    {
        let visiblityVC = self.storyboard?.instantiateViewController(withIdentifier: "VisibilityViewController") as! VisibilityViewController
        visiblityVC.completion = { tag in
                    self.selectedButton = tag
                    self.visiblityBtn.setTitle(tag == 0 ? "Public" : tag == 1 ? "Friends" : "Only Me", for: .normal)
                }
        print(selectedButton)
        visiblityVC.selectedButton = selectedButton
        navigationController?.pushViewController(visiblityVC, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        guard let cb = completion, let childrenAgeCount = numberOfChildrenTextField.text else {
            return
        }
        cb(selectedButton, childrenAge, childrenAgeCount)
        navigationController?.popViewController(animated: true)
    }
}
extension ChildrenDetailViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenAge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildrenTableViewCell", for: indexPath) as! ChildrenTableViewCell
        
        print(indexPath.row)
        cell.completionBlock = { data in
            self.childrenAge.remove(at: indexPath.row)
            self.childrenAge.insert(data ?? "", at: indexPath.row)
            tableView.reloadData()
        }
        cell.childrenAgeLabel.text = "Children \(indexPath.row) Age :"
//        cell.childrenAgeTxtField.text = userDetail?.children?[indexPath.row].age
        return cell
    }
}
