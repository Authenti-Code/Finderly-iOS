//
//  Extension.swift
//  Demo
//
//  Created by Pankush on 03/12/20.
//

import UIKit

class RootControllerProxy {
    static var shared: RootControllerProxy {
        return RootControllerProxy()
    }
    fileprivate init(){}
    //MARK:- Set Root Without Drawer Method
    func rootWithoutDrawerWithMain(_ identifier: String) {
        let blankController = storyboardMain.instantiateViewController(withIdentifier: identifier)
        var homeNavController:UINavigationController = UINavigationController()
        homeNavController = UINavigationController.init(rootViewController: blankController)
        homeNavController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = homeNavController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func rootWithDrawer(_ identifier: String) {
        let nextViewController = storyboardMain.instantiateViewController(withIdentifier: identifier)
        let navigationController = UINavigationController(rootViewController: nextViewController)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
      }
    func rootWithoutDrawerWithViewer(_ identifier: String) {
        let blankController = storyboardMain.instantiateViewController(withIdentifier: identifier)
        var homeNavController:UINavigationController = UINavigationController()
        homeNavController = UINavigationController.init(rootViewController: blankController)
        homeNavController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = homeNavController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

