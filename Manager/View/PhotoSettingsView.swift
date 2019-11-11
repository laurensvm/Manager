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
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    override func collectionViewBehaviour() {
        self.collectionView.collectionViewLayout = collectionViewLayout
        self.collectionView.register(TrackChangesSettingsCell.self, forCellWithReuseIdentifier: trackChangesCellId)
        self.collectionView.register(ImportSettingsCell.self, forCellWithReuseIdentifier: importCellId)
        self.collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        self.collectionView.clipsToBounds = true
        
    }
    
    override func didLoadDelegate() {
        super.didLoadDelegate()
        
        // Collection View
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
