//
//  ProfileViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 20/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController<ProfileView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let u = Session.shared.user {
//            v.usernameLabel.text = u.username
            
            print(u.files)
        }
        
    }
}
