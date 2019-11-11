//
//  HomeView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class HomeView: CollectionView {
    
    private lazy var viewTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Home"
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = true
        setupViews()
    }
    
    override func collectionViewBehaviour() {
        self.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: baseCellId)
        self.collectionView.isScrollEnabled = false
    }
    
    override func didLoadDelegate() {
        super.didLoadDelegate()
        
        // Collection View
        self.collectionView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 64).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: delegate.collectionViewHeight()).isActive = true
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
