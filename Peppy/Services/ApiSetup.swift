

import UIKit
import SwiftyJSON

class NetworkManager {

    // MARK:- Register Api
    
    static func registerApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.registerApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    // MARK:- Login Api
    
    static func loginApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.loginApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    // MARK:- Logout Api
    
    static func logoutApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.logoutApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    // MARK:- Change Password Api
    
    static func changePasswordApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.changePasswordApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    //MARK:- Refresh Token Api
    
    static func refreshTokenApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.refreshTokanApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    // MARK:- Get All Interests APi
    
    static func GetAllInterestsApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.GetAllInterestsApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    //MARK: Get Friend Request API
    static func GetFriendRequestApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.GetFriendRequestApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }

    //MARK: AddFriendRequestApi
    static func AddFriendRequestApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.AddFriendRequestApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
   
    //MARK: AddFriendRequestConfirmOrRejectApi
    static func AddFriendRequestConfirmOrRejectApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.AddFriendRequestConfirmOrRejectApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    //MARK: GetFriend Api
    static func GetFriendApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.GetFriendApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    //MARK: GetNearbyUsers Api
    
    static func GetNearbyUsersApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.GetNearbyUsersApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    //MARK: AddOrRemoveFavouriteFriendApi Api
    
    static func AddOrRemoveFavouriteFriendApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.AddOrRemoveFavouriteFriendApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    //MARK: GetFavouriteFriendApi Api
    
    static func GetFavouriteFriendApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.GetFavouriteFriendApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    //MARK:- Add User Profile Api
    
    static func addUserProfileApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.AddUserProfileApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    //MARK:- Get User Profile Api
    
    static func getUserProfileApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.getUserProfileApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    //MARK: ViewOtherProfileApi
    
    static func ViewOtherProfileApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.ViewOtherProfileApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    // MARK:- Forgot Password Api
    
    static func forgotPasswordApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.forgotPasswordApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    //MARK: ReportUserApi
    
    static func ReportUserApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.ReportUserApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    //MARK: RemoveFriendApi
    
    static func RemoveFriendApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(Apis.sharedInstanse.RemoveFriendApi, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? Int != 0{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else {
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }
    
    // MARK:- Profile Image Upload Api
    
    static func profileImageApi(param: [String: AnyObject], imgsData: [Data]?, callback: (( _ status: Bool , _ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.requestWithMultipleImage(Apis.sharedInstanse.AddUserProfileApi, parameters: param, imagesData: imgsData) { (response, error) in
                if error == nil{
                    if let someDictionaryFromJSON = response {
                        if someDictionaryFromJSON["status"] as? Int != 0{
                            callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                        } else {
                            callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil)
                        }
                    } else{
                        let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                        callback?(false,nil,error)
                    }
                } else {
                    callback?(false,nil,error)
                }
            }
        }
    
}

//MARK:- Refresh Token Function

func refreshToken(){
    userDefaults.removeObject(forKey: "accessToken")
    appDelegate.navigation()
}
