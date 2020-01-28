//
//  MusicViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 21/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class MusicViewController: CollectionViewController<MusicView> {
    private let networkManager: NetworkManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Music"
        
        populateBreadCrumbTrail()
    }
    
    init(withNetworkManager networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateBreadCrumbTrail() {
        self.navigationController?.viewControllers.forEach({
            if let viewController = $0 as? BreadCrumbViewController {
            self.v.breadCrumbTrail.append(viewController.getViewControllerTitle())
            }
        })
    }
}
