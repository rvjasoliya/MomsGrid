//
//  HomeViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 02/07/21.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapCollectionView: UICollectionView!
    
    var markers: [GMSMarker] = []
    var interestArray: [String] = []
    var commanInterestsArray: [String] = []
    var hideAndShowView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapCollectionView.delegate = self
        mapCollectionView.dataSource = self
        mapCollectionView.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        getUserProfile()
        getAllInterestsApi()
        GetNearbyUsers()
    }
    
    @IBAction func notificationBtnAction(_ sender: Any) {
        let notificationVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    // MARK:- MapView Marker Set
    
    func mapViewMarker() {
//        for i in 0..<self.nearByUser.count {
//            let camera = GMSCameraPosition.camera(withLatitude:i[i], longitude: custlong[i], zoom: 16.0)
//            mapView.camera = camera
//            let markerDict = GMSMarker()
//            markerDict.icon = UIImage(named: "ic_location_tag.png")
//            markerDict.position = CLLocationCoordinate2D(latitude:custlatt[i], longitude: custlong[i])
//            markerDict.map = mapView
//            markers.append(markerDict)
//        }
    }
    
    // MARK:- Get All Interest Api
    
    func getAllInterestsApi() {
        NetworkManager.GetAllInterestsApi(param: [:]) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                allInterests = Interests.modelsFromDictionaryArray(array: data?["Data"] as Any as? NSArray ?? [])
                self.mapCollectionView.reloadData()
            }
        }
    }
    
    // MARK:- Get User Profile Api
    
    func getUserProfile() {
        NetworkManager.getUserProfileApi(param: [:]) {  status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                NetworkManager.refreshTokenApi(param: [:]) { (status, data, error) in
                    if status {
                        self.getUserProfile()
                    } else{
                        refreshToken()
                    }
                }
                //refreshToken()
            }
            else {
                userDetail = UserDetail.init(dictionary: data?["Data"] as Any as! NSDictionary)
                interests = userDetail?.interests ?? []
                self.nullValueValidation()
            }
        }
    }
    //MARK: GetNearbyUsers Api
    func GetNearbyUsers() {
        NetworkManager.GetNearbyUsersApi(param: [:]) {  status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                //refreshToken()
            }
            else {
                nearbyUserDetail = UserDetail.modelsFromDictionaryArray(array: data?["Data"] as Any as? NSArray ?? [])
                self.mapCollectionView.reloadData()
                self.mapViewMarker()
            }
        }
    }
    
    // MARK:- User Detail Null Value Validation
    
    func nullValueValidation() {
        if  userDetail?.display_name == nil || userDetail?.address == nil || userDetail?.pictures?.count == 0
                || userDetail?.children?.count == 0 || userDetail?.date_of_birth == nil || userDetail?.occupation == nil || userDetail?.interests?.count == 0 || userDetail?.about_me == nil
        {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SetupProfile1of2ViewController") as! SetupProfile1of2ViewController
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}

// MARK:- MapView Delegate Method
extension HomeViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let selectedMarker = mapView.selectedMarker {
            selectedMarker.icon = UIImage(named: "ic_location_tag.png")
        }
        mapView.selectedMarker = marker
        marker.icon = UIImage(named: "ic_selected_location_tag.png")
        
        if let index = markers.firstIndex(of: marker) {
            mapCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
        mapCollectionView.isHidden = false
        return true
    }
    
}

//MARK:- Collection View Delegate And  DataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyUserDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = nearbyUserDetail[indexPath.row]
        let user_Interest = nearbyUserDetail[indexPath.row].interests ?? []
        let comman_interests = nearbyUserDetail[indexPath.row].comman_interests ?? []

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "map", for: indexPath) as! MapCollectionViewCell
        if ((model.pictures?.count ?? 0) > 0) {
            cell.customerImageView.sd_setImage(with: URL(string: imageUrl + (model.pictures?.first?.path ?? "") ) , completed: nil)
        }
        else{
            cell.customerImageView.image = UIImage(named: "noImage")
        }
        cell.customerNameLabel.text = model.name
        var interestName = ""
        for i in user_Interest {
            interestName = interestName == "" ? (i.interest ?? "") :  (interestName + ", " + (i.interest ?? ""))
        }
        cell.customerHobbyLabel.text = "Interests: \(interestName)"
        var commanInterestName = ""
        for i in comman_interests {
            commanInterestName = commanInterestName == "" ? (i.interest ?? "") :  (commanInterestName + ", " + (i.interest ?? ""))
        }
        cell.customerCommanLabel.text = "Common Interests: \(commanInterestName)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = nearbyUserDetail[indexPath.row]
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailsViewController") as! ProfileDetailsViewController
      //  newVC.selectedNearbyUserDetail = model
        newVC.other_user_uuid = model.uuid
        newVC.hideAndShowHome = hideAndShowView
        navigationController?.pushViewController(newVC, animated: true)
    }
}
