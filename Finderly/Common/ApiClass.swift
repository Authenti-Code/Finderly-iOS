//
//  ApiClass.swift
//  Finderly
//
//  Created by Pankush Mehra on 10/02/22.
//

import UIKit
import Firebase
import Alamofire

enum AppInfo {
    static let AppName = "Finderly"
    static let DeviceName =  UIDevice.current.name
    static let DeviceId =  UIDevice.current.identifierForVendor!.uuidString
    
    //MARK:-> ADDED TEMPORARY
    static let Mode = "development"
    static let Version =  "1.0"
    static let UserAgent = "\(Mode)/\(AppName)/\(Version)"
}
enum Apis{
    static let KServerUrl = "https://finderly.authenticode.biz/api/"
    static let kLogin = "login"
    static let kRegister = "register"
}
//MARK:- App Header
func headers() ->  [String:String] {
    let header = [
        "Authorization": "Bearer \(accessToken)",
        "Accept":"application/json"
    ]
    return header
}
//MARK:- Save Data Locally Methods
var accessToken: String {
    get {
        return UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey:"accessToken")
    }
}
