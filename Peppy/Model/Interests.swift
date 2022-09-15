//
//  Interest.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 17/07/21.
//

import Foundation

var interests: [Interests] = []
var allInterests: [Interests] = []

public class Interests {
    
    public var uuid : String?
    public var interest_uuid : String?
    public var interest : String?
    public var interest_name : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Interests]
    {
        var models:[Interests] = []
        for item in array
        {
            models.append(Interests(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    init(interest: String?){
        self.interest = interest
    }
    required public init?(dictionary: NSDictionary) {
        uuid = dictionary["uuid"] as? String
        interest_uuid = dictionary["interest_uuid"] as? String
        interest = dictionary["interest"] as? String
        interest_name = dictionary["interest_name"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.uuid, forKey: "uuid")
        dictionary.setValue(self.interest_uuid, forKey: "interest_uuid")
        dictionary.setValue(self.interest, forKey: "interest")
        dictionary.setValue(self.interest_name, forKeyPath: "interest_name")
        
        return dictionary
    }
    
}
