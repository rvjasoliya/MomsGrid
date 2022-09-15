//
//  FaqViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class FaqViewController: UIViewController {

    @IBOutlet weak var faqTableView: UITableView!
    
    let sectionTitle = ["Question 1","Question 2","Question 3","Question 4","Question 5"]
    let sectionDesc = ["Lorem ipsum is simply dummy text of ","Lorem ipsum is simply dummy text of the printing and typesetting industry.","Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ispum has been the industry's standard dummy text ever since the 1500s.","Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ispum has been the industry's standard dummy text ever since the 1500s.","Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ispum has been the industry's standard dummy text ever since the 1500s.Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ispum has been the industry's standard dummy text ever since the 1500s."]
    private var sectionIsExpended = [false,false,false,false,false]
    private let numberOfActualRowsForSection = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        faqTableView.delegate = self
        faqTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension FaqViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionIsExpended[section] ? (1 + numberOfActualRowsForSection) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! FaqHeaderTableViewCell
            cell.titleLabel.text = sectionTitle[indexPath.section]
            if sectionIsExpended[indexPath.section]{
                cell.setExpented()
            }
            else {
                cell.setCollpased()
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! FaqContectTableViewCell
            cell.contectLabel.text = sectionDesc[indexPath.section]
            cell.contectLabel.numberOfLines = 4
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            sectionIsExpended[indexPath.section] = !sectionIsExpended[indexPath.section]
            tableView.reloadSections([indexPath.section], with: .automatic)
        }
    }
    
}
