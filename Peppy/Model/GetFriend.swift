//
//  GetFriend.swift
//  Peppy
//
//  Created by Admin on 13/05/1943 Saka.
//

import Foundation

var getFriend : [GetFriend] = []
var getFavoriteFriend: [GetFriend] = []

public class GetFriend {
    public var uuid : String?
    public var friend_uuid : String?
    public var is_favourite : String?
    public var friend_name : String?
    public var friend_email : String?
    public var friend_profile : String?
    public var friend_Interest : Array<Interests>?
    public var commanInterest : Array<Interests>?

    public class func modelsFromDictionaryArray(array:NSArray) -> [GetFriend]
    {
        var models:[GetFriend] = []
        for item in array
        {
            models.append(GetFriend(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        uuid = dictionary["uuid"] as? String
        friend_uuid = dictionary["friend_uuid"] as? String
        is_favourite = dictionary["is_favourite"] as? String
        friend_name = dictionary["friend_name"] as? String
        friend_email = dictionary["friend_email"] as? String
        friend_profile = dictionary["friend_profile"] as? String
        if (dictionary["friend_Interest"] != nil) {
            if let details = dictionary["friend_Interest"] as? NSArray {
                friend_Interest = Interests.modelsFromDictionaryArray(array: details)
            }
        }
        if (dictionary["CommanInterest"] != nil) {
            if let details = dictionary["CommanInterest"] as? NSArray {
                commanInterest = Interests.modelsFromDictionaryArray(array: details)
            }
        }
    }
    
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.uuid, forKey: "uuid")
        dictionary.setValue(self.friend_uuid, forKey: "friend_uuid")
        dictionary.setValue(self.is_favourite, forKey: "is_favourite")
        dictionary.setValue(self.friend_name, forKey: "friend_name")
        dictionary.setValue(self.friend_email, forKey: "friend_email")
        dictionary.setValue(self.friend_profile, forKey: "friend_profile")

        return dictionary
    }

}
