//
//  HomeView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    weak var delegate: CollectionViewDelegate!
    let homeViewCellId = "homeViewCellId"
    
    private lazy var viewTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Home"
        return lb
    }()
    
    lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: cvLayout)
        cv.backgroundColor = .white
        cv.isScrollEnabled = false
        cv.register(HomeCell.self, forCellWithReuseIdentifier: homeViewCellId)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = true
        setupViews()
    }
    
    func didLoadDelegate() {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        
        // Collection View
        self.collectionView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 64).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: delegate.collectionViewHeight()).isActive = true
    }
	
    private func setupViews() {
        self.addSubview(viewTitleLabel)
        self.addSubview(collectionView)
        
        // View Title label
        self.viewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        self.viewTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        self.viewTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
