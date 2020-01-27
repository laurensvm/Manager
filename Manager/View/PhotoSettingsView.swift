//
//  PhotoSettingsView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoSettingsView: CollectionView {
    
    let trackChangesCellId = "trackChangesCellId"
    let importCellId = "importCellId"
    var breadCrumbTrail: [String] = []
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layout.sectionHeadersPinToVisibleBounds = false
        return layout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    override func collectionViewBehaviour() {
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.register(TrackChangesSettingsCell.self, forCellWithReuseIdentifier: trackChangesCellId)
        collectionView.register(ImportSettingsCell.self, forCellWithReuseIdentifier: importCellId)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.clipsToBounds = true
        
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
