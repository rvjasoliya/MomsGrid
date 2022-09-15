

import UIKit
import SwiftyJSON

@available(iOS 13.0, *)
class NetworkManager {
    
    /*static func loginApi(param: [String: AnyObject], callback: ((_ status: Bool ,_ scenarios: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.postResponseAPI(login_url, isPring: false, param: param) { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    if someDictionaryFromJSON["status"] as? String == "Success"{
                        callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                    } else { // false
                        callback?(false,someDictionaryFromJSON as? [String : AnyObject],nil) // error
                    }
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        }
    }*/
    
    static func channelDetailApi(url: String, callback: ((_ status: Bool ,_ scenarios: NSArray?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.getResponseAPI(url: url, isPring: false, completionHandler: { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    let tk = someDictionaryFromJSON["items"] as Any as? NSArray ?? []
                    callback?(true,tk,nil)
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        })
    }
    
    static func homeVideoApi(url: String, callback: ((_ status: Bool ,_ scenarios: Any?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.getResponseAPI(url: url, isPring: false, completionHandler: { (response, error) in
            if error == nil{
                if let someDictionaryFromJSON = response {
                    callback?(true,someDictionaryFromJSON,nil)
                } else{
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey:  "Invalid"]) as Error
                    callback?(false,nil,error)
                }
            } else {
                callback?(false,nil,error)
            }
        })
    }
}


@available(iOS 13.0, *)
func getChannelInfo(){
    let url = Apis.sharedInstanse.BASE_URL + "channels?part=snippet,contentDetails,statistics&key=" + Apis.sharedInstanse.YOUTUBE_API_KEY + "&id=" + Apis.sharedInstanse.YOUTUBE_CHANNEL_ID
    NetworkManager.channelDetailApi(url: url) { (status, data, err) in
        if !status{
            if err != nil {
                appDelegate.window?.rootViewController?.view.makeToast(err?.localizedDescription)
            }
        } else {
            let rs = ChannelInfo.modelsFromDictionaryArray(array: data ?? [])
            channelInfo = rs.first
        }
    }
}
