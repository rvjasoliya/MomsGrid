//
//  AppDelegate.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 01/07/21.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import Firebase
//impo

let googleApiKey = "AIzaSyB0HrGXLVtzdV6_Nn2eJvTBbskohUHA3PY"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey(googleApiKey)
        if #available(iOS 13.0, *) {
            UIWindow.appearance().overrideUserInterfaceStyle = .light
        }
        token = userDefaults.string(forKey: "accessToken") ?? ""
        print(token)
        FirebaseApp.configure()
        setupNavigation()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func setupNavigation() {
        if token.count > 0 {
            let newVC = self.storyBoard.instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
            appDelegate.window?.rootViewController = newVC
        }
        else {
            let newVC = self.storyBoard.instantiateViewController(withIdentifier: "loginNav") as! UINavigationController
            appDelegate.window?.rootViewController = newVC

        }
    }
    
    func navigation()
    {
        let newVC = self.storyBoard.instantiateViewController(withIdentifier: "loginNav") as! UINavigationController
        appDelegate.window?.rootViewController = newVC
    }

}

