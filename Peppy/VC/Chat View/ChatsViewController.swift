//
//  ChatsViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class ChatsViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var segmentView: UIView!
    lazy var chatViewController: ChatViewController = {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.addViewControllerAsChaildViewController(childViewController: vc)
        return vc
    }()
    lazy var chatsRequestViewController: ChatsRequestsViewController = {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatsRequestsViewController") as! ChatsRequestsViewController
        self.addViewControllerAsChaildViewController(childViewController: vc)
        return vc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addUnderlineForSelectedSegment()

        setupView()
    }
    @IBAction func notificationBtnAction(_ sender: Any) {
        let notificationVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        segmentedControl.changeUnderlinePosition()
        updateView()
    }
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    private func updateView(){
        chatsRequestViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 1)
        chatViewController.view.isHidden = (segmentedControl.selectedSegmentIndex == 1)
        !(segmentedControl.selectedSegmentIndex == 1) ? chatViewController.GetFriendApi() : chatsRequestViewController.GetFriendRequestApi()
    }
    private func setupSegmentedControl(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Chats", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Chat Requests", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
    }
    private func addViewControllerAsChaildViewController(childViewController: UIViewController){
        addChild(childViewController)
        chatView.addSubview(childViewController.view)
        childViewController.view.frame = self.chatView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
}
