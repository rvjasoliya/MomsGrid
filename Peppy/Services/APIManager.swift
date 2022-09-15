

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

var token = ""

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    //MARK:- Get Response Api
    
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
    
    //MARK:- Get Response With Detail Api
    
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
    
    //MARK:- Post Resoponse Api
    
    func postResponseAPI(_ url:String, isPring: Bool = false,param:[String: AnyObject],completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){
        print("post url", url)
        showLoading()
        if isConnectedToNetwork() {
            AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(token)"])
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
                            //                                                        print(someDictionaryFromJSON)
                            
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
    
    // MARK:- Request With Multiple Image APi
    
    func requestWithMultipleImage(_ url:String, parameters: [String : Any], imagesData: [Data]?, completionHandler: @escaping (AnyObject?, NSError?)->()) ->() {
        showLoading()
        if isConnectedToNetwork() {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)",
                "Content-type": "multipart/form-data",
                "Connection": "keep-alive",
            ]
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                //var i = 0
                for (indx,imgData) in (imagesData ?? []).enumerated() {
                    multipartFormData.append(imgData, withName: "images[]", fileName: "\(timeStamp())\(indx).jpeg", mimeType: "image/jpeg")
                    //i += 1
                }
            }, to: url, method: .post, headers: headers)
            .uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(queue: .main, options: .allowFragments){ (response) in
                switch response.result {
                case .success( _):
                    dissmissLoader()
                    do {
                        dissmissLoader()
                        let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]
                        //                                                        print(someDictionaryFromJSON)
                        
                        completionHandler(someDictionaryFromJSON as AnyObject?,nil)
                    } catch{
                        dissmissLoader()
                        completionHandler(nil,response.error as NSError?)
                        print("Error : ",error)
                    }
                case .failure(let error):
                    dissmissLoader()
                    completionHandler(nil,error as NSError?)
                    print("Request failed with error: \(error)")
                }
            }
        } else{
            DispatchQueue.main.async(execute: {
                dissmissLoader()
            })
        }
    }
    
}
