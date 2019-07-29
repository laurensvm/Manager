//
//  WelcomeView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 22/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit


class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    var username: String {
        return usernameTextField.text ?? ""
    }
    
    var password: String {
        return passwordTextField.text ?? ""
    }
    
    private lazy var welcomeLabel: UILabel = {
		let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.text = "Login"
        return lb
    }()
    
    private lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Username"
        tf.font = Theme.fonts.avenirLight(size: 14)
        tf.tintColor = UIColor.lightGray
        tf.setIcon(#imageLiteral(resourceName: "user"))
        
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.emailAddress
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.font = Theme.fonts.avenirLight(size: 14)
        tf.tintColor = UIColor.lightGray
        tf.setIcon(#imageLiteral(resourceName: "password"))
        tf.isSecureTextEntry = true
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let lb = UIButton()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setTitle("Log In", for: [.normal])
        lb.setTitleColor(Theme.colors.lightBlue, for: [.normal])
        lb.titleLabel?.font = Theme.fonts.avenirBlack(size: 24)
        lb.layer.cornerRadius = 6
        lb.backgroundColor = .white
        lb.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Theme.colors.lightBlue
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
    }
    
    private func setupViews() {
        
        self.addSubview(self.welcomeLabel)
        self.addSubview(self.usernameTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.loginButton)
        
        // Set autolayout constraints
        
        // Welcome label
        self.welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        self.welcomeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.welcomeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
        
        // Username Textfield
        self.usernameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 64).isActive = true
        self.usernameTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.usernameTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Password Textfield
        self.passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16).isActive = true
        self.passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.passwordTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Login Button
        self.loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 64).isActive = true
        self.loginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    @objc func didTapLoginButton(_ button: UIButton) {
        delegate?.loginView(self, didTapLoginButton: button)
    }
}
