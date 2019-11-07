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
    var loginCompletion: (() -> ())!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
    }
    
    init(networkManager: NetworkManager, onLoginCompletion completion: @escaping () -> ()) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
        self.loginCompletion = completion
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ view: LoginView, didTapLoginButton button: UIButton) {
        let username = "theexission@gmail.com"
//        let username = customView.username.lowercased()
//        let passsword = customView.password
        let password = "Ld4qIZSy6CFMuAESFSsadkfhj23475SjaNfVC"
        
        networkManager.credentialManager.login(username: username, password: password, completion: { successful, error in
            DispatchQueue.main.async {
                self.customView.indicatorView.stopAnimating()
                if successful {
                    self.loginCompletion()
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alertViewController = AlertViewController(withMessage: error)
                    self.present(alertViewController, animated: false, completion: nil)
                }
            }
        })
    }
}

