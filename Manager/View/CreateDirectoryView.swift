//
//  CreateDirectoryView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 06/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class CreateDirectoryView: View {
    
    var delegate: CreateDirectoryDelegate?
    var directory: Directory?
    
    private var containerViewConstraints: [NSLayoutConstraint]!
    
    let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
    	
        // Setup shadow
        v.layer.cornerRadius = 15
        v.layer.masksToBounds = false
        v.layer.shadowColor = Theme.colors.lightGrey.cgColor
        v.layer.shadowOpacity = 0.8
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 5
        
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 18)
        lb.textColor = Theme.colors.baseBlack
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var directoryName: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Name"
        tf.font = Theme.fonts.avenirLight(size: 14)
        tf.tintColor = UIColor.lightGray
        
        tf.textAlignment = .center
    
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
//        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf.borderStyle = UITextField.BorderStyle.none
        
        return tf
    }()
    
    private let createButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Create Directory", for: [.normal])
        bt.setTitleColor(Theme.colors.baseBlack, for: [.normal])
        bt.titleLabel?.font = Theme.fonts.avenirBlack(size: 14)
        bt.layer.cornerRadius = 6
        bt.backgroundColor = Theme.colors.baseOrange
        return bt
    }()
    
    private let completed: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "verified")
        iv.alpha = 0.9
        return iv
    }()
    
    func didLoadDelegate() {
        createButton.addTarget(delegate!, action: #selector(delegate!.didTapCreateDirectory(_:)), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: delegate!, action: #selector(delegate!.removeSelf(_:)))
        tapGestureRecognizer.delegate = delegate as? UIGestureRecognizerDelegate
        self.addGestureRecognizer(tapGestureRecognizer)
        
        // Add textfield delegate
        directoryName.delegate = delegate
        
        // Set titlelabel text
        if let dir = self.directory,
            let name = dir.name {
            titleLabel.text = "Creating new directory inside of directory '\(name)'"
        }
//        titleLabel.text = "Create Directory inside\n'root'"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.backgroundColor = .clear
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(containerView)
        addSubview(createButton)
        addSubview(titleLabel)
        addSubview(directoryName)
        addSubview(completed)
    }
    
    private func setupConstraints() {
        
        // Container View Constraints
        containerViewConstraints = [
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            
            completed.heightAnchor.constraint(equalToConstant: 0),
            completed.widthAnchor.constraint(equalToConstant: 0),
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        
        // Setup constraints of view
        NSLayoutConstraint.activate([
            // Title label
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            
            directoryName.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0),
            directoryName.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32),
            directoryName.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32),
            directoryName.heightAnchor.constraint(equalToConstant: 32),
            
            
            // Button
            createButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            createButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            createButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            
             // Completed imageView
            completed.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0),
            completed.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0),
            ]
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CreateDirectoryView {
    func loading() {
        UIView.animate(withDuration: 0.5, animations: {
            self.createButton.setTitle("Creating...", for: .normal)
        }, completion: nil)
    }
    
    func failed(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.createButton.setTitle("Invalid name", for: .normal)
            self.createButton.backgroundColor = .white
        }, completion: { _ in
            UIView.animate(withDuration: 1.5, animations: {
                self.createButton.alpha = 0.95
            }, completion: { _ in
                completion()
            })
        })
    }
    
    func accept(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.createButton.alpha = 0
            self.directoryName.alpha = 0
            self.titleLabel.alpha = 0
        }) { (_) in
            
            self.updateContainerViewConstraints()
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.completed.alpha = 1
                }, completion: { _ in
                      completion()
                })
            })
        }
    }
    
    private func updateContainerViewConstraints() {
        NSLayoutConstraint.deactivate(containerViewConstraints)
        NSLayoutConstraint.activate([
            // Container View Updated
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.widthAnchor.constraint(equalToConstant: 100),
            
            completed.heightAnchor.constraint(equalToConstant: 40),
            completed.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}


