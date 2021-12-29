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

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // FalSignlback on earlier versions
        }
        IQKeyboardManager.shared.resignFirstResponder()
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = appcolor.backgroundShadow
        //set root
        rootWithoutDrawer()
        return true
    }
    //root to controller
    func rootWithoutDrawer() {
        let blankController = storyBoard.instantiateViewController(withIdentifier: "LoginVC")
        var homeNavController:UINavigationController = UINavigationController()
        homeNavController = UINavigationController.init(rootViewController: blankController)
        homeNavController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = homeNavController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

