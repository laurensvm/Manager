//
//  SettingsViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 14/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class SettingsViewController: ViewController<SettingsView> {
    
    var networkManager: NetworkManager!
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Settings"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
