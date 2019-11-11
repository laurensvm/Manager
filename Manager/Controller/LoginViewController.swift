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
    private let loginCompletion: (() -> ())!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        let username = "theexission@gmail.com"
//        let username = customView.username.lowercased()
//        let passsword = customView.password
        let password = "Ld4qIZSy6CFMuAESFSsadkfhj23475SjaNfVC"
        
        networkManager.credentialManager.login(username: username, password: password, completion: { successful, error in
            DispatchQueue.main.async {
                self.v.indicatorView.stopAnimating()
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

