//
//  HomeView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate!
    let homeViewCellId = "homeViewCellId"
	
//    private lazy var navigationBar: UINavigationBar = {
//        let nb = UINavigationBar()
//        nb.translatesAutoresizingMaskIntoConstraints = false
//        nb.prefersLargeTitles = true
//        nb.backgroundColor = .white
//        nb.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        nb.shadowImage = UIImage()
//
//        // Set icons here
//
//        return nb
//    }()
    
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
        cv.register(HomeViewCell.self, forCellWithReuseIdentifier: homeViewCellId)
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
//        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 164).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: delegate.collectionViewHeight()).isActive = true
    }
	
    private func setupViews() {
//        self.addSubview(navigationBar)
        self.addSubview(viewTitleLabel)
        self.addSubview(collectionView)
        
        // Navigationbar
//        self.navigationBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        self.navigationBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
//        self.navigationBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
//        self.navigationBar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // View Title label
        self.viewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        self.viewTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.viewTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
