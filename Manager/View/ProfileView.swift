//
//  ProfileView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 20/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class ProfileView: View {
    
    private let profileImageSize: CGFloat = 128
    
    lazy var viewTitleLabel: UILabel = {
        let lb = Label()
        lb.text = "Profile"
        return lb
    }()
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "arnold_schwarzenegger")
        
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    lazy var usernameLabel: UILabel = {
        let lb = Label()
        lb.textColor = Theme.colors.lightGrey
        lb.font = Theme.fonts.avenirBlack(size: 20)
        lb.textAlignment = .center
        lb.text = "Arnold Schwarzenegger"
        return lb
    }()
    
    let filesView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.clipsToBounds = false
        
        // Setup shadow
        v.layer.shadowColor = Theme.colors.lightGrey.cgColor
        v.layer.shadowOpacity = 0.8
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 15
        v.layer.masksToBounds = false
        
        return v
    }()
    
    let viewFilesTitleLabel: UILabel = {
        let lb = Label()
        lb.font = Theme.fonts.avenirBlack(size: 24)
        lb.textColor = Theme.colors.baseBlack
        lb.text = "Your Files"
        return lb
    }()
    
    let noFilesUploaded: UILabel = {
        let lb = Label()
        lb.font = Theme.fonts.avenirBlack(size: 14)
        lb.textColor = Theme.colors.lighterGrey
        lb.text = "NO FILES UPLOADED YET"
        return lb
    }()
    
    let line: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Theme.colors.lighterGrey
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = true
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(filesView)
        addSubview(viewTitleLabel)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(viewFilesTitleLabel)
        addSubview(noFilesUploaded)
        addSubview(line)
        
        NSLayoutConstraint.activate([
            // View Title label
            viewTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            viewTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            viewTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
        ])
        
        // Profile Image View
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 32),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageSize),
            NSLayoutConstraint.init(item: profileImageView, attribute: .width, relatedBy: .equal, toItem: profileImageView, attribute: .height, multiplier: 1, constant: 0)
        ])
        
        profileImageView.layer.cornerRadius = profileImageSize / 2
        
        // Username Label
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 24),
            usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
        ])
        
        // Files containerView
        NSLayoutConstraint.activate([
            filesView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 32 + profileImageSize / 2),
            filesView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            filesView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            filesView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 100),
        ])
        
        // View Files label
        NSLayoutConstraint.activate([
            viewFilesTitleLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 48),
            viewFilesTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            viewFilesTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16)
        ])
        
        // No Files Uploaded + Line
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: viewFilesTitleLabel.bottomAnchor, constant: 16),
            line.leftAnchor.constraint(equalTo: leftAnchor, constant: 48),
            line.rightAnchor.constraint(equalTo: rightAnchor, constant: -48),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            noFilesUploaded.centerXAnchor.constraint(equalTo: centerXAnchor),
            noFilesUploaded.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 128)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
