//
//  PhotoSettingsView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoSettingsView: View {
    
    var delegate: CollectionViewDelegate?
    let trackChangesCellId = "trackChangesCellId"
    let importCellId = "importCellId"
    let headerId = "headerId"
    var breadCrumbTrail: [String] = []
    
    private lazy var collectionView: UICollectionView = {
        // CollectionViewFlowLayout
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 8
        cvLayout.minimumInteritemSpacing = 8
        cvLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        cvLayout.sectionHeadersPinToVisibleBounds = false
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.register(TrackChangesSettingsCell.self, forCellWithReuseIdentifier: trackChangesCellId)
        cv.register(ImportSettingsCell.self, forCellWithReuseIdentifier: importCellId)
        cv.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.clipsToBounds = true
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = true
        setupViews()
        setupConstraints()
    }
    
    func didLoadDelegate() {
        collectionView.delegate = delegate!
        collectionView.dataSource = delegate!
        
        // Collection View
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupViews() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
