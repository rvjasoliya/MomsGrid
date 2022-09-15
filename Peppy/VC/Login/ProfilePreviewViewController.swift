//
//  ProfilePreviewViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class ProfilePreviewViewController: UIViewController {
    
    @IBOutlet weak var profileImageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var profilePreviewView: UIView!
    @IBOutlet weak var generalDetailsView: UIView!
    @IBOutlet weak var generalDetailsBottomView: UIView!
    @IBOutlet weak var basicDetailsView: UIView!
    @IBOutlet weak var basicDetailsBottomView: UIView!
    
    @IBOutlet weak var displayNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var aboutMeLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var interestsLbl: UILabel!
    @IBOutlet weak var childrenDetailsLbl: UILabel!
    @IBOutlet weak var childrenCountLbl: UILabel!
    
    var addUserProfile: UserDetail?
    var imageArray: [Pictures] = []
    var timer = Timer()
    var counter = 0
    var interestArray : [String] = []
    var childrenArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageCollectionView.delegate = self
        profileImageCollectionView.dataSource = self
        UIViewDesign()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        getUserProfile()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pageControlAction(_ sender: UIPageControl) {
        self.profileImageCollectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }

    @IBAction func makeChangesBtnAction(_ sender: Any) {
        for vc in self.navigationController!.viewControllers {
            if let myViewCont = vc as? SetupProfile1of2ViewController
            {
                self.navigationController?.popToViewController(myViewCont, animated: true)
            }
        }
    }
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationAccessViewController") as! LocationAccessViewController
        navigationController?.pushViewController(locationVC, animated: true)
    }
    
    // MARK:- Get User Profile Api
    
    func getUserProfile() {
        NetworkManager.getUserProfileApi(param: [:]) {  status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                self.addUserProfile = UserDetail.init(dictionary: data?["Data"] as Any as? NSDictionary ?? [:])
                interests = userDetail?.interests ?? []
                self.setProfilePreviewData()
                self.profileImageCollectionView.reloadData()
            }
        }
    }
    
    // MARK:-  Page Control
    
    @objc func changeImage() {
        if counter < imageArray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.profileImageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.profileImageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
    }
    
    // MARK:- UI View Round Corner
    
    func UIViewDesign() {
        // Profile Preview view top corner radius
        profilePreviewView.layer.cornerRadius = 10
        profilePreviewView.clipsToBounds = true
        profilePreviewView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner ]
        
        // general Details view top corner radius
        generalDetailsView.layer.cornerRadius = 10
        generalDetailsView.clipsToBounds = true
        generalDetailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner ]
        
        // generalDetailsBottomView view bottom corner radius
        generalDetailsBottomView.layer.cornerRadius = 10
        generalDetailsBottomView.clipsToBounds = true
        generalDetailsBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        // basic details view top corner radius
        basicDetailsView.layer.cornerRadius = 10
        basicDetailsView.clipsToBounds = true
        basicDetailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner ]
        
        // BasicDetailsBottomView Bottom corner radius
        basicDetailsBottomView.layer.cornerRadius = 10
        basicDetailsBottomView.layer.masksToBounds = true
        basicDetailsBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    }
    
    // MARK:- Set Data In Profile Preview
    
    func setProfilePreviewData() {
        emailLbl.text =  addUserProfile?.email ?? ""
        displayNameLbl.text = addUserProfile?.display_name ?? ""
        ageLbl.text = addUserProfile?.date_of_birth ?? ""
        addressLbl.text = addUserProfile?.address ?? ""
        childrenCountLbl.text = addUserProfile?.no_of_children ?? ""
        aboutMeLbl.text = addUserProfile?.about_me
        occupationLbl.text = addUserProfile?.occupation
        childrenArray.removeAll()
        for i in 0..<(addUserProfile?.children?.count ?? 0) {
            let children = "\(addUserProfile?.children?[i].children ?? "") : \(addUserProfile?.children?[i].age ?? "")"
            childrenArray.append(children)
        }
        childrenDetailsLbl.text = childrenArray.joined(separator: "\n")
        interestArray.removeAll()
        for i in 0..<(addUserProfile?.interests?.count ?? 0) {
            let interest = "\(addUserProfile?.interests?[i].interest ?? "")"
            interestArray.append(interest)
        }
        interestsLbl.text = interestArray.joined(separator: "\n")
       
        imageArray = addUserProfile?.pictures ?? []
        pageControl.numberOfPages = imageArray.count
        if imageArray.count != 0 {
            pageControl.currentPage = 0
        }
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
}


//MARK:- Collection View Datasource and Delegate Methods

extension ProfilePreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePreviewCollectionViewCell", for: indexPath) as! ProfilePreviewCollectionViewCell
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
    
    
}
