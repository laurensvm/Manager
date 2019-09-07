//
//  AppDelegate.swift
//  File Manager
//
//  Created by Laurens Van Mieghem on 20/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        var networkManager = NetworkManager()
        

        let rootViewController = HomeViewController()
        rootViewController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "dashboard"), tag: 0)
        let rootViewController2 = PhotoTableViewController()
        rootViewController2.tabBarItem = UITabBarItem(title: "Documents", image: #imageLiteral(resourceName: "folder"), tag: 1)
        let rootViewController3 = HomeViewController()
        rootViewController3.tabBarItem = UITabBarItem(title: "Recent", image: #imageLiteral(resourceName: "clock"), tag: 2)
        let rootViewController4 = HomeViewController()
        rootViewController4.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "menu"), tag: 3)
        let tabBarController = BubbleTabBarController()
        
        let navigationBarController = UINavigationController(navigationBarClass: CustomNavigationBar.self, toolbarClass: nil)
        navigationBarController.viewControllers = [rootViewController]
        
        tabBarController.viewControllers = [navigationBarController, rootViewController2, rootViewController3, rootViewController4]
        tabBarController.tabBar.tintColor = Theme.colors.baseOrange
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

