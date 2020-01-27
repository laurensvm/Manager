//
//  VideoView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 21/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class VideoView: CollectionView {
    
    var breadCrumbTrail: [String] = []
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.sectionHeadersPinToVisibleBounds = false
        return layout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = true
        setupViews()
    }
    
    override func collectionViewBehaviour() {
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 5
        collectionView.isScrollEnabled = true
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: baseCellId)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func didLoadDelegate() {
        super.didLoadDelegate()
        
        NSLayoutConstraint.activate([
            // Collection View
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
