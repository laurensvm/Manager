//
//  CollectionViewHeader.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
   
    private lazy var viewTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Photos"
        return lb
    }()
    
    lazy var breadCrumb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = Theme.colors.lightGrey
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
		self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = .blue
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(viewTitleLabel)
        self.addSubview(breadCrumb)
        
        // View Title label
        self.viewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.viewTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        self.viewTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true

        // BreadCrumb
        self.breadCrumb.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 16).isActive = true
        self.breadCrumb.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        self.breadCrumb.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
//        self.breadCrumb.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 32)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
