//
//  ProfileViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 05/07/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var generalDetailTopView: UIView!
    @IBOutlet weak var generalDetailBottomView: UIView!
    @IBOutlet weak var basicDetailTopView: UIView!
    @IBOutlet weak var basicDetailsBottomView: UIView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var profileEmailLbl: UILabel!
    @IBOutlet weak var profileAddressLbl: UILabel!
    @IBOutlet weak var profileAgeLbl: UILabel!
    @IBOutlet weak var profileChildrenCountLbl: UILabel!
    @IBOutlet weak var profileAboutMeLbl: UILabel!
    @IBOutlet weak var profileOccupationLbl: UILabel!
    @IBOutlet weak var profileChildrenLabel: UILabel!
    @IBOutlet weak var profileInterestLabel: UILabel!
    
    var chiledArray:[String] = []
    var imageArray: [Pictures] = []
    var timer = Timer()
    var counter = 0
    var interestArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageCollectionView.delegate = self
        profileImageCollectionView.dataSource = self
        
        backButton.isHidden = true
        UIViewDesign()
//        setValueInProfile()
//        imageArray = userDetail?.pictures ?? []
//        pageControl.numberOfPages = imageArray.count
//        pageControl.currentPage = 0
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserProfile()
        
    }
    func getUserProfile() {
        NetworkManager.getUserProfileApi(param: [:]) {  status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                userDetail = UserDetail.init(dictionary: data?["Data"] as Any as! NSDictionary)
                self.setValueInProfile()
                self.profileImageCollectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setValueInProfile() {

        profileNameLbl.text = userDetail?.name
        profileEmailLbl.text = userDetail?.email
        profileAgeLbl.text = userDetail?.date_of_birth
        profileAddressLbl.text = userDetail?.address
        profileChildrenCountLbl.text = "\(userDetail?.children?.count ?? 0)"
        profileAboutMeLbl.text = userDetail?.about_me
        profileOccupationLbl.text = userDetail?.occupation
        interestArray.removeAll()
        for i in 0..<(userDetail?.interests?.count ?? 0) {
            let interest = "\(userDetail?.interests?[i].interest ?? "")"
            interestArray.append(interest)
        }
        chiledArray = []
        childrenArray = userDetail?.children ?? []
        profileInterestLabel.text = interestArray.joined(separator: "\n")
        for i in childrenArray.indices {
            let children = "\(childrenArray[i].children ?? "") : \(childrenArray[i].age ?? "")"
            chiledArray.append(children)
        }
        profileChildrenLabel.text = chiledArray.joined(separator: "\n")
        
        imageArray = userDetail?.pictures ?? []
        pageControl.numberOfPages = imageArray.count
        
        if imageArray.count != 0 {
            pageControl.currentPage = 0
        }
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        }
    }
    
    func UIViewDesign() {
        
        // general Details view top corner radius
        generalDetailTopView.layer.cornerRadius = 10
        generalDetailTopView.clipsToBounds = true
        generalDetailTopView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner ]
        
        // generalDetailsBottomView view bottom corner radius
        generalDetailBottomView.layer.cornerRadius = 10
        generalDetailBottomView.clipsToBounds = true
        generalDetailBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        // basic details view top corner radius
        basicDetailTopView.layer.cornerRadius = 10
        basicDetailTopView.clipsToBounds = true
        basicDetailTopView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner ]
        
        // BasicDetailsBottomView Bottom corner radius
        basicDetailsBottomView.layer.cornerRadius = 10
        basicDetailsBottomView.layer.masksToBounds = true
        basicDetailsBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
    }
    
    // MARK:-  Page Control
    @IBAction func pageControlAction(_ sender: UIPageControl) {
        self.profileImageCollectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func editProfileBtnAction(_ sender: Any) {
        let editProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        editProfileVC.isEdit = true
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @IBAction func settingBtnAction(_ sender: Any) {
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingsViewController
        navigationController?.pushViewController(settingVC, animated: true)
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
}


//MARK:- Collection View Datasource and Delegate Methods

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileImg", for: indexPath) as! ProfileCollectionViewCell
        if cell.profileImgView == cell.viewWithTag(111) as? UIImageView
        {
            cell.profileImgView.sd_setImage(with: URL(string: imageUrl + (imageArray[indexPath.row].path ?? "")), placeholderImage: UIImage(named: "noImage"), options: .highPriority, context: nil)
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
