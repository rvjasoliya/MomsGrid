

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

@available(iOS 13.0, *)
class APIManager: NSObject {
    static let sharedInstance = APIManager()
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    func getResponseAPI(url:String,isPring: Bool = false,completionHandler:@escaping (AnyObject?, NSError?)->()) ->() {
        print("get url", url)
//        showLoading()
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default)
            .validate(/*contentType: ["text/plain"]*/)
            .responseString(completionHandler: {(response) in
                switch response.result {
                case .success( _):
                    if (isPring) {
                        print(response.result)
                    }
                    dissmissLoader()
                    do {
                        dissmissLoader()
                        let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]
                        //print(someDictionaryFromJSON)
                        completionHandler(someDictionaryFromJSON as AnyObject?,nil)
                    } catch{
                        dissmissLoader()
                        completionHandler(nil,response.error as NSError?)
                        print("Error : ",error)
                    }
                case .failure( let error):
                    dissmissLoader()
                    completionHandler(nil,response.error as NSError?)
                    print("Request failed with error: \(error)")
                }
            })
    }
    
    func getResponseWithDetailAPI(url:String,isPring: Bool = false, param: [String: AnyObject],completionHandler:@escaping (AnyObject?, NSError?)->()) ->() {
        print("get detail", url)
        showLoading()
        if let jsonString = dictionaryToString(Detail: param) {
            if let url = URL(string: url) {
                let jsonDatas = jsonString.data(using: .utf8, allowLossyConversion: false)!

                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                //request.setValue(headerValue, forHTTPHeaderField: headerKey)
                request.httpBody = jsonDatas
                
                AF.request(request).responseJSON {
                    (response) in
                    //print(response)
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        if (isPring) {
                            print(response.result)
                        }
                        if let _ = json.dictionary {
                            do {
                                dissmissLoader()
                                let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]
                                completionHandler(someDictionaryFromJSON as AnyObject?,nil)
                            } catch {
                                completionHandler(nil,response.error as NSError?)
                                print("error: \(error)")
                            }
                        } else{
                            completionHandler(nil,response.error as NSError?)
                        }
                    case .failure(let error):
                        dissmissLoader()
                        completionHandler(nil,response.error as NSError?)
                        print("Request failed with error: \(error)")
                    }
                }
            }
        }
    }
    
    func postResponseAPI(_ url:String, isPring: Bool = false,param:[String: AnyObject],completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){
        print("post url", url)
        showLoading()
        if isConnectedToNetwork() {
            AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer "])
                .responseString(completionHandler: { (response) in
                    switch response.result{
                    case .success( _):
                        if (isPring) {
                            print(response.result)
                        }
                        dissmissLoader()
                        do {
                            dissmissLoader()
                            let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]
                            //print(someDictionaryFromJSON)
                            completionHandler(someDictionaryFromJSON as AnyObject?,nil)
                        } catch{
                            dissmissLoader()
                            completionHandler(nil,response.error as NSError?)
                            print("Error : ",error)
                        }
                    case .failure( let error):
                        dissmissLoader()
                        completionHandler(nil,response.error as NSError?)
                        print("Request failed with error: \(error)")
                    }
                })
        } else{
            DispatchQueue.main.async(execute: {
                dissmissLoader()
            })
        }
    }

}
