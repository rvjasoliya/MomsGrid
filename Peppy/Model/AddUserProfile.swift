//
//  addUserProfile.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 16/07/21.
//

import Foundation


public class AddUserProfile {
    public var uuid : String?
    public var name : String?
    public var display_name : String?
    public var profile_picture_uuid : String?
    public var email : String?
    public var login_type : String?
    public var occupation : String?
    public var about_me : String?
    public var date_of_birth : String?
    public var address : String?
    public var no_of_children: String?
    public var pictures : Array<String>?
    public var interests : Array<String>?
    public var children : Array<String>?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AddUserProfile]
    {
        var models:[AddUserProfile] = []
        for item in array
        {
            models.append(AddUserProfile(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    init (display_name:String? , date_of_birth: String? , address: String?, no_of_children: String?) {
        self.display_name = display_name ?? ""
        self.date_of_birth = date_of_birth ?? ""
        self.address = address ?? ""
        self.no_of_children = no_of_children ?? ""
    }
    
    required public init?(dictionary: NSDictionary) {
        
        uuid = dictionary["uuid"] as? String
        name = dictionary["name"] as? String
        display_name = dictionary["display_name"] as? String
        profile_picture_uuid = dictionary["profile_picture_uuid"] as? String
        email = dictionary["email"] as? String
        login_type = dictionary["login_type"] as? String
        occupation = dictionary["occupation"] as? String
        about_me = dictionary["about_me"] as? String
        date_of_birth = dictionary["date_of_birth"] as? String
        address = dictionary["address"] as? String
        no_of_children = dictionary["no_of_children"] as? String
        
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.uuid, forKey: "uuid")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.display_name, forKey: "display_name")
        dictionary.setValue(self.profile_picture_uuid, forKey: "profile_picture_uuid")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.login_type, forKey: "login_type")
        dictionary.setValue(self.occupation, forKey: "occupation")
        dictionary.setValue(self.about_me, forKey: "about_me")
        dictionary.setValue(self.date_of_birth, forKey: "date_of_birth")
        dictionary.setValue(self.address, forKey: "address")
        dictionary.setValue(self.no_of_children, forKey: "no_of_children")
        return dictionary
    }
    
}
