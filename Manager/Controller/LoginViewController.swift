//
//  ViewController.swift
//  File Manager
//
//  Created by Laurens Van Mieghem on 20/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    let loginView: LoginView = LoginView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    fileprivate func setupViews() {
        self.view.addSubview(self.loginView)
        
        // Autolayout
        self.loginView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.loginView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
    }


}

