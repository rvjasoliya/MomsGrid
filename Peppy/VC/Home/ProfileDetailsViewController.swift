//
//  ProfileDetailsViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 03/07/21.
//

import UIKit
import PopupDialog
import Toast_Swift

class ProfileDetailsViewController: UIViewController {
    
    @IBOutlet weak var profileImageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var sayHelloBtn: UIButton!
    @IBOutlet weak var grneralDetailsTopView: UIView!
    @IBOutlet weak var generalDetailsBottomView: UIView!
    @IBOutlet weak var basicDetailsTopView: UIView!
    @IBOutlet weak var basicDetailsBottomView: UIView!
    @IBOutlet weak var BottomButtonView: UIView!
    @IBOutlet weak var topButtonView: UIView!
    @IBOutlet weak var MsgCountView: UIView!
    @IBOutlet weak var buttonViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ButtonStackView: UIStackView!
    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var about_meLabel : UILabel!
    @IBOutlet weak var date_of_birthLabel : UILabel!
    @IBOutlet weak var occupationLabel : UILabel!
    @IBOutlet weak var interetsLabel : UILabel!
    @IBOutlet weak var childrenAgeLabel : UILabel!
    @IBOutlet weak var numberOfChildrenCountLabel: UILabel!
    
    var chathideAndShow = false
    var msgBtnHideAndShow = false
    var acceptButtonHideAndShow = false
    
//    var otherUserDetail: UserDetail?
    var viewOtherUserDetails: UserDetail?
    var selectedButton = 0
    var selectedAcceptAndRejectButton = 0
    var checkFriendIndex:Int = 0
    var request_uuid: String?
    var friend_uuid: String?
    var other_user_uuid: String?
    var imageArray: [Pictures] = []
    var timer = Timer()
    var counter = 0
    var hideAndShow: Bool?
    var hideAndShowHome: Bool?
    var chatTap = true
    var image : UIImage?
    var name = ""
    var interestArray: [String] = []
    var childrenArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image = UIImage(named: "mom.jpg")
        name = "Samira_K"
        profileImageCollectionView.delegate = self
        profileImageCollectionView.dataSource = self
        favouriteBtnDesign()
        UIViewDesign()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard ButtonStackView.isHidden == hideAndShow else {
            if hideAndShow == true {
                ViewOtherProfileApi()
                buttonViewHeight.constant = 40
                ButtonStackView.isHidden = hideAndShow ?? true
            }
            else{
                ViewOtherProfileApi()
                BottomButtonView.isHidden = true
                topButtonView.isHidden = true
                MsgCountView.isHidden = true
                ButtonStackView.isHidden = false
//                setupFriendUserData()
            }
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIViewDesign() {
        
        // general Details view top corner radius
        grneralDetailsTopView.layer.cornerRadius = 10
        grneralDetailsTopView.clipsToBounds = true
        grneralDetailsTopView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner ]
        
        // generalDetailsBottomView view bottom corner radius
        generalDetailsBottomView.layer.cornerRadius = 10
        generalDetailsBottomView.clipsToBounds = true
        generalDetailsBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        // basic details view top corner radius
        basicDetailsTopView.layer.cornerRadius = 10
        basicDetailsTopView.clipsToBounds = true
        basicDetailsTopView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner ]
        
        // BasicDetailsBottomView Bottom corner radius
        basicDetailsBottomView.layer.cornerRadius = 10
        basicDetailsBottomView.layer.masksToBounds = true
        basicDetailsBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    }
    
    func setupFriendUserData() {
        friend_uuid = viewOtherUserDetails?.uuid
        displayNameLabel.text = viewOtherUserDetails?.name
        emailLabel.text = viewOtherUserDetails?.email
        addressLabel.text = viewOtherUserDetails?.address
        about_meLabel.text = viewOtherUserDetails?.about_me
        date_of_birthLabel.text = viewOtherUserDetails?.date_of_birth
        occupationLabel.text = viewOtherUserDetails?.occupation
        interestArray.removeAll()
        for i in 0..<(viewOtherUserDetails?.interests?.count ?? 0) {
            let interest = "\(viewOtherUserDetails?.interests?[i].interest ?? "")"
            interestArray.append(interest)
        }
        interetsLabel.text = interestArray.joined(separator: "\n")
        childrenArray.removeAll()
        for i in 0..<(viewOtherUserDetails?.children?.count ?? 0) {
            let children = "\(viewOtherUserDetails?.children?[i].children ?? "") : \(viewOtherUserDetails?.children?[i].age ?? "")"
            print(children)
            childrenArray.append(children)
        }
        numberOfChildrenCountLabel.text = "\(viewOtherUserDetails?.children?.count ?? 0)"
        childrenAgeLabel.text = childrenArray.joined(separator: "\n")
        imageArray = viewOtherUserDetails?.pictures ?? []
        pageControl.numberOfPages = imageArray.count
        if imageArray.count != 0 {
            pageControl.currentPage = 0
        }
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        }
        selectedButton = Int(viewOtherUserDetails?.is_favorite ?? "") ?? 0
        favouriteBtn.isSelected = selectedButton == 0 ? false : true
        checkFriendIndex =  viewOtherUserDetails?.req ?? 0
        favouriteBtn.setTitle((checkFriendIndex == 0 || checkFriendIndex == 1 ? "Add Friend" : "Favourite"), for: .normal)
        sayHelloBtn.setTitle((checkFriendIndex == 0 ? "Say Hello" :  checkFriendIndex == 1 ? "Cancel Request" : "Chat"), for: .normal)
        if checkFriendIndex == 1 {
            sayHelloBtn.setImage(nil, for: .normal)
        }
        print(checkFriendIndex)
    }
    
    // MARK:-  Page Control
    @IBAction func pageControlAction(_ sender: UIPageControl) {
        
        self.profileImageCollectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if let coll  = profileImageCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < imageArray.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    self.pageControl.currentPage = (indexPath?.row)! + 1
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    self.pageControl.currentPage = (indexPath?.row)!
                }
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func favouriteBtnDesign() {
        if #available(iOS 13.0, *) {
            favouriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            favouriteBtn.setTitle("Favourite", for: .normal)
            favouriteBtn.setImage(UIImage(systemName:"heart.fill"), for: .selected)
            favouriteBtn.setTitle("UnFavourite", for: .selected)
        }
    }
    @IBAction func favouriteBtnAction(_ sender: UIButton) {
        //        sender.isSelected = !sender.isSelected
        if checkFriendIndex == 0 || checkFriendIndex == 1 {
            addFriendAlert()
        }
        else if checkFriendIndex == 2 {
            if !favouriteBtn.isSelected {
                selectedButton = 1
                self.AddOrRemoveFavouriteFriendApi()
                favouriteBtn.isSelected = true
            }
            else {
                selectedButton = 0
                self.AddOrRemoveFavouriteFriendApi()
                favouriteBtn.isSelected = false
            }
        }
    }
    
    func addFriendAlert()
    {
        alertDesign()
        let title = "Add Friend"
        let message = "Please must be you have first send friend request."
        let popup = PopupDialog(title: title, message: message)
        
        let buttonOne = CancelButton(title: "Ok", height: 50)
        {
            self.dismiss(animated: true, completion: nil)
        }
        buttonOne.backgroundColor = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1)
        buttonOne.titleColor = UIColor.white
        buttonOne.titleFont = UIFont(name: "Avenir Next Demi Bold", size: 17)
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    func alertDesign() {
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont = UIFont(name: "Avenir Next Medium", size: 20)!
        pv.titleColor = .black
        pv.messageFont = UIFont(name: "Avenir Next Regular", size: 17)!
        pv.messageColor = UIColor.black
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = 10
    }
    
    func AddOrRemoveFavouriteFriendApi() {
        let param = ["status" : "\(selectedButton)", "friend_uuid" : "\(friend_uuid ?? "")"] as [String: Any] as [String:AnyObject]
        print(param)
        NetworkManager.AddOrRemoveFavouriteFriendApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
            }
            else {
                self.view.window?.makeToast(data?["message"] as Any as? String ?? "")
            }
        }
    }
    
    @IBAction func chatBtnAction(_ sender: Any) {
        if checkFriendIndex == 0 {
            let chatVC = self.storyboard?.instantiateViewController(withIdentifier: "ChattingVC") as! ChattingViewController
            chatVC.imageSave = viewOtherUserDetails?.profile_picture_uuid
            chatVC.nameSave = viewOtherUserDetails?.name
            chatVC.other_user_uuid = viewOtherUserDetails?.uuid
            chatVC.friend_uuid = viewOtherUserDetails?.uuid
            chatVC.chateBtnHideShow = chathideAndShow
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
        else if checkFriendIndex == 1 {
            selectedAcceptAndRejectButton = 0
            addFriendRequestConfirmOrRejectApi()
        }
        else if checkFriendIndex == 2 {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChattingVC") as! ChattingViewController
//            vc.nameSave = viewOtherUserDetails?.name
//            vc.other_user_uuid = viewOtherUserDetails?.uuid
//            vc.chatTap = chatTap
//            self.navigationController?.pushViewController(vc, animated: true)
//
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChattingVC") as! ChattingViewController
            vc.nameSave = viewOtherUserDetails?.name
            vc.other_user_uuid = viewOtherUserDetails?.uuid
            vc.friend_uuid = viewOtherUserDetails?.uuid
            vc.chatTap = chatTap
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func acceptBtnAction(_ sender: UIButton) {
        selectedAcceptAndRejectButton = sender.tag
        if selectedAcceptAndRejectButton == 0{
            //reject
            self.addFriendRequestConfirmOrRejectApi()
        }
        else if selectedAcceptAndRejectButton == 1 {
            // accept
            self.addFriendRequestConfirmOrRejectApi()
        }
    }
    
    @IBAction func msgBtnAction(_ sender: Any) {
        let chatVC = self.storyboard?.instantiateViewController(withIdentifier: "ChattingVC") as! ChattingViewController
        chatVC.other_user_uuid = other_user_uuid
        chatVC.friend_uuid = friend_uuid
        chatVC.request_uuid = request_uuid
        chatVC.imageSave = viewOtherUserDetails?.profile_picture_uuid
        chatVC.nameSave = viewOtherUserDetails?.name ?? ""
        chatVC.msgBtnHideAndShow = msgBtnHideAndShow
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    //MARK: addFriendRequestConfirmOrRejectApi
    func addFriendRequestConfirmOrRejectApi() {
        let param = ["status" : "\(selectedAcceptAndRejectButton)", "request_uuid" : "\(request_uuid ?? "")"] as [String: Any] as [String:AnyObject]
        NetworkManager.AddFriendRequestConfirmOrRejectApi(param: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }

            }
            else {
                self.view.window?.makeToast(data?["message"] as Any as? String ?? "")
                if self.selectedAcceptAndRejectButton == 1 {
                    let chattingVC = self.storyboard?.instantiateViewController(withIdentifier: "ChattingVC") as! ChattingViewController
                    chattingVC.profileDetailTap = self.acceptButtonHideAndShow
                    self.navigationController?.pushViewController(chattingVC, animated: true)
                }
                else if self.selectedAcceptAndRejectButton == 0{
                    self.navigationController?.popViewController(animated: true)
                }
                //                self.chatRequestTableView.reloadData()
            }
        }
    }
    
    // MARK:- View Other User Profile Api
    
    func ViewOtherProfileApi() {
        
        let param = ["other_uuid" : "\(other_user_uuid ?? "")"] as [String: Any] as [String:AnyObject]
        
        print(param)
        NetworkManager.ViewOtherProfileApi(param: param) {  status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
            }
            else {
                self.viewOtherUserDetails = UserDetail.init(dictionary: data?["Data"] as Any as? NSDictionary ?? [:])
                self.setupFriendUserData()
                self.profileImageCollectionView.reloadData()
            }
        }
    }
}

//MARK:- Collection View Datasource and Delegate Methods

extension ProfileDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profile image", for: indexPath) as! ProfileImageCollectionViewCell
        if cell.profileImageView == cell.viewWithTag(111) as? UIImageView
        {
            cell.profileImageView.sd_setImage(with: URL(string: imageUrl + (imageArray[indexPath.row].path ?? "")), placeholderImage: UIImage(named: "noImage"), options: .highPriority, context: nil)
            self.pageControl.currentPage = self.pageControl.currentPage > indexPath.row ? indexPath.row + 1 : indexPath.row - 1
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = profileImageCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
}
