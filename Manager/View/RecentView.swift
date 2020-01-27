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
        let lb = Label()
        lb.text = "Recent"
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = true
        setupViews()
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(viewTitleLabel)
        
        NSLayoutConstraint.activate([
            // View Title label
            viewTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            viewTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            viewTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
