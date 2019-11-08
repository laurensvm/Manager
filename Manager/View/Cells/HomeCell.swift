
//
//  HomeViewCell.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    private lazy var pictureView: UIView = {
        let v = UIView()
        v.backgroundColor = Theme.colors.baseOrange
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 12
        return v
    }()
    
    lazy var pictureImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 9, y: 9, width: 32, height: 32))
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    lazy var title: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 16)
        lb.textColor = Theme.colors.baseBlack
        lb.text = "Photos"
        return lb
    }()
    
    lazy var progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.trackTintColor = .white
        pv.progressTintColor = Theme.colors.baseOrange
        pv.layer.masksToBounds = true
        pv.layer.cornerRadius = 2
        return pv
    }()
    
    lazy var storageLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenir(size: 14)
        lb.textColor = Theme.colors.baseBlack
        lb.text = "- GB"
        lb.textAlignment = NSTextAlignment.right
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        
    }
    
    
    private func setupViews() {
        // Configure superview
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = Theme.colors.superLightGrey
        self.backgroundColor = .white
        
        // Setup shadow
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
        self.layer.shadowColor = Theme.colors.lightGrey.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        
        
        self.addSubview(pictureView)
        self.addSubview(title)
        self.addSubview(storageLabel)
        self.addSubview(progressView)
        pictureView.addSubview(pictureImageView)
        
        // Picture view
        self.pictureView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        self.pictureView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.pictureView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.pictureView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
		// Progress View
        self.progressView.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 12).isActive = true
        self.progressView.leftAnchor.constraint(equalTo: self.pictureView.rightAnchor, constant: 16).isActive = true
        self.progressView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24).isActive = true

        // Title label
        self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        self.title.leftAnchor.constraint(equalTo: pictureView.rightAnchor, constant: 16).isActive = true
        self.title.widthAnchor.constraint(equalToConstant: 150).isActive = true

        // Storage label
        self.storageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.storageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        self.storageLabel.leftAnchor.constraint(equalTo: title.rightAnchor, constant: 16).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
