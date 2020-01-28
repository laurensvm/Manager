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
        let lb = Label()
        lb.text = "Home"
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = true
        setupViews()
    }
    
    override func collectionViewBehaviour() {
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: baseCellId)
        collectionView.isScrollEnabled = false
    }
    
    override func didLoadDelegate() {
        super.didLoadDelegate()
        
        NSLayoutConstraint.activate([
            // Collection View
            collectionView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 64),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: delegate.collectionViewHeight()),
        ])
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
