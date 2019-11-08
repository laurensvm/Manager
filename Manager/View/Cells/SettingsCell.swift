//
//  SettingsCell.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    
    
    
    private let imageContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Theme.colors.baseOrange
        v.layer.cornerRadius = 8.0
        return v
    }()
    
    lazy var rightArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "arrow-right-50")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var _imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "user")
        iv.image = iv.image?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var _titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "User"
        return lb
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = true
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        
        // Setup shadow
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
        self.layer.shadowColor = Theme.colors.lightGrey.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
           
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(_titleLabel)
        addSubview(imageContainerView)
        addSubview(rightArrow)
        
        imageContainerView.addSubview(_imageView)
    }
    
    func setupConstraints() {
        
        // Title Label Constraints
        NSLayoutConstraint.activate([
            imageContainerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            imageContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            imageContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            
            NSLayoutConstraint.init(item: imageContainerView, attribute: .width, relatedBy: .equal, toItem: imageContainerView, attribute: .height, multiplier: 1, constant: 0),
            
            _imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor, constant: 0),
            _imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor, constant: 0),
            _imageView.widthAnchor.constraint(equalToConstant: 24),
            _imageView.heightAnchor.constraint(equalToConstant: 24),
            
            _titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            _titleLabel.leftAnchor.constraint(equalTo: _imageView.rightAnchor, constant: 24),
            _titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            
            
            rightArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            rightArrow.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            rightArrow.widthAnchor.constraint(equalToConstant: 12),
            rightArrow.heightAnchor.constraint(equalToConstant: 12),
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
