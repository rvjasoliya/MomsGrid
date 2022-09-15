
import Foundation

//var picturesArray : [Pictures] = []

public class Pictures {
    public var uuid : String?
    public var media_uuid : String?
    public var path : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Pictures]
    {
        var models:[Pictures] = []
        for item in array
        {
            models.append(Pictures(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        uuid = dictionary["uuid"] as? String
        media_uuid = dictionary["media_uuid"] as? String
        path = dictionary["path"] as? String
    }
    
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.uuid, forKey: "uuid")
        dictionary.setValue(self.media_uuid, forKey: "media_uuid")
        dictionary.setValue(self.path, forKey: "path")
        
        return dictionary
    }
    
}
