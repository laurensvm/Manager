//
//  ViewController.swift
//  File Manager
//
//  Created by Laurens Van Mieghem on 20/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit



class LoginViewController: ViewController<LoginView> {
    
    var networkManager: NetworkManager!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
    }
    
    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ view: LoginView, didTapLoginButton button: UIButton) {
        
        // Add keychain integration here
        let username = customView.username.lowercased()
        let password = customView.password
        
        self.networkManager.login(withUsername: username, andPassword: password, completion: { token, error in
            
            if let token = token {
                
                // Set keychain updates and userdefaults
                // TO-DO: Fix with secure way instead of userdefaults !
                UserDefaults.standard.setLoggedInStatus(value: true)
                UserDefaults.standard.setUserProperties(credentials: Credentials(username: username, password: password, token: token))
                
                DispatchQueue.main.async {
                    self.customView.indicatorView.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                }
            }
            if error != nil {
                print(error!)
            }
            DispatchQueue.main.async {
                self.customView.indicatorView.stopAnimating()
            }
            
        })
    }
}

