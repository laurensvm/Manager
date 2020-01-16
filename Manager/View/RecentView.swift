//
//  RecentView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 16/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class RecentView: CollectionView {
    
    private lazy var viewTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Recent"
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = true
        setupViews()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(viewTitleLabel)
        
        // View Title label
        self.viewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.viewTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        self.viewTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
