//
//  constants.swift
//  Findirly
//
//  Created by D R Thakur on 24/12/21.
//

import Foundation
import UIKit

let AppName = "Findirly"
let KAppDelegate = UIApplication.shared.delegate as! AppDelegate
let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
let Defaults = UserDefaults.standard
extension UIColor {
    static var bbackgroundShadow: UIColor {
        return UIColor(red: 0.1960784314, green: 0.6156862745, blue: 0.6117647059, alpha: 0.50)
    }
}
//app colors
enum appcolor{
    static let backgroundShadow = UIColor(red: 0.1960784314, green: 0.6156862745, blue: 0.6117647059, alpha: 0.50)
}
enum AppAlert{
    static let mail = "Please enter valid email"
    static let usrname = "Please enter valid user name"
    static let phone = "Please enter valid phone number"
    static let passwrd = "Please enter valid password"
    static let confirmPswrd = "Please enter valid password"
    static let otpVerify = "Enter OTP for verify."
    static let emailTaken = "Email has taken already"
}
