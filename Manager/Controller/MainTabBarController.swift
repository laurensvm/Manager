//
//  MainTabBarControllerViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 29/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController()
        
        self.viewControllers = [homeViewController]

        // Do any additional setup after loading the view.
    }

}
