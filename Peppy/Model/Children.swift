
import Foundation

var childrenArray : [Children] = []

public class Children {
    public var uuid : String?
    public var children : String?
    public var age : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Children]
    {
        var models:[Children] = []
        for item in array
        {
            models.append(Children(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    
    required public init?(dictionary: NSDictionary) {
        
        uuid = dictionary["uuid"] as? String
        children = dictionary["children"] as? String
        age = dictionary["age"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.uuid, forKey: "uuid")
        dictionary.setValue(self.children, forKey: "children")
        dictionary.setValue(self.age, forKey: "age")
        
        return dictionary
    }
    
}
