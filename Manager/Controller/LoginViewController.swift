//
//  ViewController.swift
//  File Manager
//
//  Created by Laurens Van Mieghem on 20/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit



class LoginViewController: ViewController<LoginView> {
    
    private let networkManager: NetworkManager
    private let transitionDelegate: DemoTransitionController = DemoTransitionController()
    private let loginCompletion: (() -> ())!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        }
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        v.delegate = self
        v.didLoadDelegate()
    }
    
    init(networkManager: NetworkManager, onLoginCompletion completion: @escaping () -> ()) {
        self.networkManager = networkManager
        self.loginCompletion = completion
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ view: LoginView, didTapLoginButton button: UIButton) {
        
        let username = AppConfig.username
        let password = AppConfig.password
//        let username = customView.username.lowercased()
//        let passsword = customView.password
        
        
        networkManager.credentialManager.login(username: username, password: password, completion: { successful, error in
            DispatchQueue.main.async {
                self.v.indicatorView.stopAnimating()
                if successful {
                    self.loginCompletion()
                    
//                    if false {
//                        let demoModeVC = DemoModePopUpViewController()
//                        demoModeVC.transitioningDelegate = self.transitionDelegate
//                        self.present(demoModeVC, animated: true, completion: nil)
//
//                        // Dismiss
//                        DispatchQueue.main.asyncAfter(deadline: .now() + self.transitionDelegate.seconds, execute: {
//                            demoModeVC.dismiss(animated: true, completion: nil)
//                        })
//                    }
                
                    
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    let alertViewController = AlertViewController(withType: .error, andMessage: error)
                    self.present(alertViewController, animated: false, completion: nil)
                }
            }
        })
    }
}

extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dissmissKeyBoard(_ sender: UITapGestureRecognizer) {
//        customView.usernameTextField.resignFirstResponder()
//        customView.passwordTextField.resignFirstResponder()
    }
}

