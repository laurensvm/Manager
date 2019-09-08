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
        
        let networkManager = NetworkManager()
        
        // General NavigationBar appearance
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        
        // Temporary fill up for the tabbar controller
        let rootViewController3 = HomeViewController()
        rootViewController3.tabBarItem = UITabBarItem(title: "Recent", image: #imageLiteral(resourceName: "clock"), tag: 2)
        let rootViewController4 = HomeViewController()
        rootViewController4.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "menu"), tag: 3)
        let tabBarController = BubbleTabBarController()
        
        // Setup home view with navigation controller
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "dashboard"), tag: 0)
        let homeViewNavigationController = CustomNavigationController(navigationBarClass: CustomNavigationBar.self, toolbarClass: nil)
        homeViewNavigationController.viewControllers = [homeViewController]
        
        // Setup documents view with navigation controller
        let documentsViewController = DocumentsViewController(withControllerTitle: "Documents", andDirectories: ["Foto's", "Video's", "Cracks", "Personal", "Education", "Werk", "Sport", "Public", "Etc"])
        documentsViewController.tabBarItem = UITabBarItem(title: "Documents", image: #imageLiteral(resourceName: "folder"), tag: 1)
        let documentsViewNavigationController = CustomNavigationController(navigationBarClass: CustomNavigationBar.self, toolbarClass: nil)
        documentsViewNavigationController.viewControllers = [documentsViewController]
        
        tabBarController.viewControllers = [
            homeViewNavigationController,
            documentsViewNavigationController,
            rootViewController3,
            rootViewController4
        ]
        tabBarController.tabBar.tintColor = Theme.colors.baseOrange
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        if !UserDefaults.standard.isLoggedIn() {
            let loginViewController = LoginViewController(networkManager: networkManager)
            tabBarController.present(loginViewController, animated: false, completion: nil)
        }
        
        return true
    }

}

