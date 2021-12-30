//
//  CustomTabBar.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
import SOTabBar

class CustomTabBar: SOTabBarController {
    override func loadView() {
        super.loadView()
        SOTabBarSetting.tabBarTintColor = .clear 
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
       // SOTabBarSetting.tabBarSizeImage = CGSize(width: 50.0, height: 50.0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVCID")
        let chatStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoriesVCID")
        let sleepStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HookedVCID")
        let musicStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVCID")
        let meStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVCID")
        
        homeStoryboard.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home-Inactive"), selectedImage: UIImage(named: "Home-Active"))
        chatStoryboard.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(named: "Categories-Inactive"), selectedImage: UIImage(named: "Categories-Active"))
        sleepStoryboard.tabBarItem = UITabBarItem(title: "Hooked", image: UIImage(named: "Hooked-Inactive"), selectedImage: UIImage(named: "Hooked-Active"))
        musicStoryboard.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(named: "Notification-Inactive"), selectedImage: UIImage(named: "Notification-Active"))
        meStoryboard.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Profile-Inactive"), selectedImage: UIImage(named: "Profile-Active"))
           
        viewControllers = [homeStoryboard, chatStoryboard,sleepStoryboard,musicStoryboard,meStoryboard]
    }
    
}


extension CustomTabBar: SOTabBarControllerDelegate {
    func tabBarController(_ tabBarController: SOTabBarController, didSelect viewController: UIViewController) {
        print(viewController.tabBarItem.title ?? "")
    }
}


