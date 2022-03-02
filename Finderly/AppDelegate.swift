//
//  AppDelegate.swift
//  Findirly
//
//  Created by D R Thakur on 22/12/21.
//

import UIKit
import IQKeyboardManagerSwift

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let storyBoard = UIStoryboard(name: "Main", bundle: nil)
let Home = UserDefaults.standard.bool(forKey: "logged_in")

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 2)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // FalSignlback on earlier versions
        }
        if Home == true{
            RootControllerProxy.shared.rootWithDrawer("CustomTabBarID")
        }else{
            RootControllerProxy.shared.rootWithDrawer("LoginVCID")
        }
        IQKeyboardManager.shared.resignFirstResponder()
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = appcolor.backgroundShadow
        //set root
        return true
    }
 
}

