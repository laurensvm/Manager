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
    var networkManager = NetworkManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupApplicationHierarchy()
        
        return true
    }
    
}

extension AppDelegate {
    private func setupApplicationHierarchy() {
        
        // General NavigationBar appearance
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        
        // Temporary fill up for the tabbar controller
        let rootViewController3 = HomeViewController(withNetworkManager: networkManager)
        rootViewController3.tabBarItem = UITabBarItem(title: "Recent", image: #imageLiteral(resourceName: "clock"), tag: 2)
        let tabBarController = BubbleTabBarController()
        
        // Setup home view with navigation controller
        let homeViewController = HomeViewController(withNetworkManager: networkManager)
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "dashboard"), tag: 0)
        let homeViewNavigationController = CustomNavigationController(navigationBarClass: CustomNavigationBar.self, toolbarClass: nil)
        homeViewNavigationController.viewControllers = [homeViewController]
        
        // Setup documents view with navigation controller
        let documentsViewController = DocumentsViewController(withNetworkManager: networkManager, andControllerTitle: "Documents", andId: 1)
        documentsViewController.tabBarItem = UITabBarItem(title: "Documents", image: #imageLiteral(resourceName: "folder"), tag: 1)
        let documentsViewNavigationController = CustomNavigationController(navigationBarClass: CustomNavigationBar.self, toolbarClass: nil)
        documentsViewNavigationController.viewControllers = [documentsViewController]
        
        // Setup settings view with navigation controller
        let settingsViewController = SettingsViewController(withNetworkManager: networkManager)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "menu"), tag: 3)
        let settingsViewNavigationController = CustomNavigationController(navigationBarClass: CustomNavigationBar.self,
                                                                          toolbarClass: nil)
        settingsViewNavigationController.viewControllers = [settingsViewController]
        
        tabBarController.viewControllers = [
            homeViewNavigationController,
            documentsViewNavigationController,
            rootViewController3,
            settingsViewNavigationController
        ]
        tabBarController.tabBar.tintColor = Theme.colors.baseOrange
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
//        if !networkManager.credentialManager.hasValidCredentials() {
            let loginViewController = LoginViewController(networkManager: networkManager, onLoginCompletion: setupPhotoManager)
            loginViewController.modalPresentationStyle = .fullScreen
            tabBarController.present(loginViewController, animated: false, completion: nil)
//        }
    }
    
    func setupPhotoManager() {
        
        // Handle the document uploads from the PHAsset library here
//        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
//            let photoManager = PhotoManager(withNetworkManager: self.networkManager)
//            photoManager.beginImportingAssets()
//        }
    }

}

