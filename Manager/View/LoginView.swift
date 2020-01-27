//
//  WelcomeView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 22/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit


class LoginView: View {
    
    weak var delegate: LoginViewDelegate?
    
    var username: String {
        return usernameTextField.text ?? ""
    }
    
    var password: String {
        return passwordTextField.text ?? ""
    }
    
    private lazy var welcomeLabel: UILabel = {
		let lb = Label()
        lb.text = "File Manager"
        return lb
    }()
    
    private lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.font = Theme.fonts.avenirLight(size: 14)
        tf.tintColor = .lightGray
        tf.setIcon(#imageLiteral(resourceName: "user"))
        
        if #available(iOS 13, *) {
            tf.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        }
        
        let placeholderString = NSAttributedString.init(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        tf.attributedPlaceholder = placeholderString
        
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
        tf.backgroundColor = .white
        tf.font = Theme.fonts.avenirLight(size: 14)
        tf.tintColor = .lightGray
        tf.setIcon(#imageLiteral(resourceName: "password"))
        
        let placeholderString = NSAttributedString.init(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        tf.attributedPlaceholder = placeholderString
        
        if #available(iOS 13, *) {
            tf.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        }
        tf.isSecureTextEntry = true
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Log In", for: [.normal])
        bt.setTitleColor(Theme.colors.baseBlack, for: [.normal])
        bt.titleLabel?.font = Theme.fonts.avenirBlack(size: 24)
        bt.layer.cornerRadius = 6
        bt.backgroundColor = Theme.colors.baseOrange
        bt.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = true
        
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(welcomeLabel)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        // Set autolayout constraints
        
        NSLayoutConstraint.activate([
            // Welcome label
            welcomeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -125),
            welcomeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            welcomeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
        

            // Username Textfield
            usernameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 64),
            usernameTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            usernameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),

            // Password Textfield
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            // Login Button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 64),
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        
        ])

    }
    
    func didLoadDelegate() {
        
        passwordTextField.delegate = delegate!
        usernameTextField.delegate = delegate!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    @objc func didTapLoginButton(_ button: UIButton) {
        animateIndicatorView()
        delegate?.loginView(self, didTapLoginButton: button)
    }
}
