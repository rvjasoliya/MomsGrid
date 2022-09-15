//
//  VisibilityViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class VisibilityViewController: UIViewController {
    
    @IBOutlet weak var publicRadioBtn: UIButton!
    @IBOutlet weak var friendsRadioBtn: UIButton!
    @IBOutlet weak var onlyMeRadioBtn: UIButton!
    
    var selectedButton = 2
    let radioController: RadioButtonController = RadioButtonController()
    
    typealias CB = (_ tag:Int) -> ()
    var completion:CB?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radioController.buttonsArray = [publicRadioBtn,friendsRadioBtn,onlyMeRadioBtn]
        if selectedButton == 0 {
            radioController.defaultButton = publicRadioBtn
        }
        else if selectedButton ==  1 {
            radioController.defaultButton = friendsRadioBtn
        }
        else {
            radioController.defaultButton = onlyMeRadioBtn
        }
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        guard let cb = completion else {
            return
        }
        cb(selectedButton)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func publicRadioBtnAction(_ sender: UIButton) {
        selectedButton = 0
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func friendsRadioBtnAction(_ sender: UIButton) {
        selectedButton = 1
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func onlyMeRadioBtnAction(_ sender: UIButton) {
        selectedButton = 2
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
    
}
