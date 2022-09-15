//
//  GetFriendRequest.swift
//  Peppy
//
//  Created by Admin on 13/05/1943 Saka.
//

import Foundation

var getFriendRequest: [GetFriendRequest] = []

public class GetFriendRequest {
    public var request_uuid : String?
    public var user_uuid : String?
    public var user_name : String?
    public var user_email : String?
    public var user_Interest : Array<Interests>?
    public var user_CommanInterest : Array<Interests>?
    public var profile : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [GetFriendRequest]
    {
        var models:[GetFriendRequest] = []
        for item in array
        {
            models.append(GetFriendRequest(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        request_uuid = dictionary["request_uuid"] as? String
        user_uuid = dictionary["user_uuid"] as? String
        user_name = dictionary["user_name"] as? String
        user_email = dictionary["user_email"] as? String
        if (dictionary["user_Interest"] != nil) {
            if let details = dictionary["user_Interest"] as? NSArray {
                user_Interest = Interests.modelsFromDictionaryArray(array: details)
            }
        }
        if (dictionary["user_CommanInterest"] != nil) {
            if let details = dictionary["user_CommanInterest"] as? NSArray {
                user_CommanInterest = Interests.modelsFromDictionaryArray(array: details)
            }
        }
        profile = dictionary["profile"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.request_uuid, forKey: "request_uuid")
        dictionary.setValue(self.user_uuid, forKey: "user_uuid")
        dictionary.setValue(self.user_name, forKey: "user_name")
        dictionary.setValue(self.user_email, forKey: "user_email")
        dictionary.setValue(self.profile, forKey: "profile")

        return dictionary
    }

}
