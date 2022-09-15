 
 
 import UIKit
 import Foundation
 import MBProgressHUD
 // import Reachability
 import SystemConfiguration
 // import SDWebImage
 import Security
 
 
 let IS_iPAD = UIDevice.current.userInterfaceIdiom == .pad
 let IS_iPHONE = UIDevice.current.userInterfaceIdiom == .phone
 
 var defaultFont = "AvenirNext"
 var BundleID = "com.rv.Peppy"
 var appStoreID =  1111111111
 var appFullName = "Peppy"
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
 // let reachability = try! Reachability()
 var progressHud = MBProgressHUD()
 
 let orangeColor = "#F7190D"
 
 let userDefaults = UserDefaults.standard
 
 func showLoading() {
    if progressHud.superview != nil {
        progressHud.hide(animated: false)
    }
    progressHud = MBProgressHUD.showAdded(to: (appDelegate.window?.rootViewController!.view)!, animated: true)
    
    if #available(iOS 9.0, *) {
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.gray
    } else {
        // Fallback on earlier versions
        //            progressHud.activityIndicatorColor = UIColor.gray
    }
    
    //progressHud.activityIndicatorColor = darkPinkColor
    //progressHud.bezelView.color = violetColor
    DispatchQueue.main.async {
        progressHud.show(animated: true)
    }
 }
 
 
 func dissmissLoader() {
    DispatchQueue.main.async {
        progressHud.hide(animated: true)
    }
 }
 
 func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
        return false
    }
    // Working for Cellular and WIFI
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    let ret = (isReachable && !needsConnection)
    
    return ret
 }
 
 extension Data {
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
 }
 
 func isNameValid(name: String) -> Bool {
    let nameRegex = "[A-Za-z][A-Za-z\\s]*"
    let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
    return nameTest.evaluate(with: name)
 }
 
 func isEmailValid(email: String) -> Bool {
    if email.count == 0 || email.contains("..") {
        return false
    }
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with: email)
 }
 
 //accepts only letters, spaces and special characters only
 func isTitleValid(title: String) -> Bool {
    let titleRegex = "[A-Za-z.,\\?'_%+\\-!@$&():;/\"\\s]*"
    let titleTest = NSPredicate(format: "SELF MATCHES %@", titleRegex)
    return titleTest.evaluate(with: title)
 }
 
 func saveImage(name: String, image: UIImage) -> Bool {
    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
        return false
    }
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        try data.write(to: directory.appendingPathComponent(name)!)
        return true
    } catch {
        print(error.localizedDescription)
        return false
    }
 }
 
 func getSavedImage(named: String?) -> UIImage? {
    if let named = named {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
    }
    return nil
 }
 
 func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if length == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    return result
 }
 
 func dictionaryToString(Detail : [String: AnyObject]) -> String? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: Detail, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
        return jsonString
    }catch {
        print("Error : ",error.localizedDescription)
        return nil
    }
 }
 
 //activity indicator
 func getConfigureActivityIndicator(table : UITableView) -> UIActivityIndicatorView {
    var activityIndicator = UIActivityIndicatorView()
    let indicatorHeight : CGFloat = 40
    activityIndicator = UIActivityIndicatorView(style: .white)
    activityIndicator.color = UIColor.lightGray
    activityIndicator.frame = CGRect(x: 0, y: 0, width: table.frame.size.width, height: indicatorHeight)
    activityIndicator.backgroundColor = UIColor.clear
    return activityIndicator
 }
 
 func alertOk(title: String, message: String, cancelButton: String,vc: UIViewController, cancelHandler: ((UIAlertAction) -> ())?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: cancelButton, style: .default, handler: cancelHandler)
    
    //        let attributedString = NSAttributedString(string: title, attributes: [
    //            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15), //your font here
    //            NSAttributedStringKey.foregroundColor : primaryColorDark
    //            ])
    //
    alertController.addAction(cancelAction)
    
    //        alertController.setValue(attributedString, forKey: "attributedTitle")
    alertController.view.tintColor = UIColor.blue
    
    vc.present(alertController, animated: true, completion: nil)
 }
 
 func alert(title: String, message: String, okButton: String, cancelButton: String,vc: UIViewController, okHandler: ((UIAlertAction) -> ())?, cancelHandler: ((UIAlertAction) -> ())?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: okButton, style: .default, handler: okHandler)
    let cancelAction = UIAlertAction(title: cancelButton, style: .cancel, handler: cancelHandler)
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    vc.present(alertController, animated: true, completion: nil)
 }
 
 struct ScreenSize
 {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
 }
 
 struct DeviceType
 {
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6_7        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P_7P      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_11_P       = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
 }
 
 
 func timeStamp() -> String
 {
    return "\(Date().timeIntervalSinceNow)"
 }

 
