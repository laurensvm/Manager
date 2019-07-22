//
//  WelcomeView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 22/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    let welcomeLabel: UILabel = {
		let lb = UILabel()
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.text = "Login"
        lb.frame = CGRect(x: Theme.inset.double, y: 200, width: 200, height: 100)
        return lb
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: Theme.inset.double, y: 400, width: 200, height: 40))
        tf.placeholder = "Username"
        tf.font = Theme.fonts.avenirLight(size: 14)
        tf.tintColor = UIColor.lightGray
        tf.setIcon(#imageLiteral(resourceName: "user"))
        
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        self.addSubview(self.welcomeLabel)
        self.addSubview(self.usernameTextField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView: UITextFieldDelegate {
    
}
