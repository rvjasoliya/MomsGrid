//
//  Apis.swift
//  Youtubely
//
//  Created by iMac on 06/07/21.
//

import Foundation

class Apis: NSObject {
    
    static let sharedInstanse = Apis()
    
    static var baseURL = "http://momsgrid.sumayinfotech.com/api/auth/"
    let registerApi = baseURL + "register"
    let loginApi = baseURL + "login"
    let logoutApi = baseURL + "logout"
    let changePasswordApi = baseURL + "ChangePassword"
    let refreshTokanApi = baseURL + "refresh"
    let GetAllInterestsApi = baseURL + "GetAllInterests"
    let AddUserProfileApi = baseURL + "AddUserProfile"
    let getUserProfileApi = baseURL + "GetUserProfile"
    let forgotPasswordApi = baseURL + "forgotpassword"
    let GetFriendRequestApi = baseURL + "GetFriendRequest"
    let AddFriendRequestApi = baseURL + "AddFriendRequest"
    let AddFriendRequestConfirmOrRejectApi = baseURL + "AddFriendRequestConfirmOrReject"
    let AddOrRemoveFavouriteFriendApi = baseURL + "AddOrRemoveFavouriteFriend"
    let GetFriendApi = baseURL + "GetFriend"
    let GetFavouriteFriendApi = baseURL + "GetFavouriteFriend"
    let GetNearbyUsersApi = baseURL + "GetNearbyUsers"
    let ViewOtherProfileApi = baseURL + "ViewOtherProfile"
    let ReportUserApi = baseURL + "ReportUser"
    let RemoveFriendApi = baseURL + "RemoveFriend"

}

var imageUrl = "http://momsgrid.sumayinfotech.com"
