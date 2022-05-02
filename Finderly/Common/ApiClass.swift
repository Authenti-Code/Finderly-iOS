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
    static let verifyOtp = "signupStep2Verification"
    static let kForgortPassword = "forgotPassword"
    static let kProfileUpload = "signupStep3Verification"
    static let kForgotVerifyOtp = "forgotPasswordOtpVerification"
    static let kCreateNewPassword = "resetPassword"
    static let kResendOtp = "resendOTP"
    static let kHome = "home"
    static let kCategory = "getCategorie"
    static let kGetCategoryBusinessLists = "getbusinessCategory"
    static let kNotification = "getNotifications"
    static let kLogout = "logout"
    static let kGetProfile = "getProfile"
    static let kGetBusinessHooked = "getbusinessHooked"
    static let kUpdateProfile = "updateProfile"
    static let kNotificationStatus = "notificationStatus"
    static let kTodayRecommended = "seeAllRecommended"
    static let kBusinessDetail = "businessDetails"
    static let kIndividualBusiness = "seeAllIndividual"
    static let kLikebusiness = "likeBusiness"
    static let kHookBusiness = "hookedBusiness"
    static let kSpecialization = "getSpecialization"
    static let kseeAllSponsore = "seeAllSponsored"
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
