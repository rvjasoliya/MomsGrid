//
//  LocationAccessViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit
import CoreLocation

class LocationAccessViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func locationBtnAction(_ sender: Any) {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        if CLLocationManager.locationServicesEnabled()
        {
            switch(CLLocationManager.authorizationStatus())
            {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Authorize.")
                let newVC = self.storyboard?.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
                appDelegate.window?.rootViewController = newVC
                break
            case .notDetermined:
                print("Not determined.")
                let newVC = self.storyboard?.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
                appDelegate.window?.rootViewController = newVC
                break
            case .restricted:
                print("Restricted.")
                let newVC = self.storyboard?.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
                appDelegate.window?.rootViewController = newVC
                break
            case .denied:
                print("Denied.")
                let newVC = self.storyboard?.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
                appDelegate.window?.rootViewController = newVC
            @unknown default:
                break
            }
        }
    }
    
}
