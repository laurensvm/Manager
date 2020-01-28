//
//  SettingsView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 14/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class SettingsView: CollectionView {
    
    private lazy var viewTitleLabel: UILabel = {
        let lb = Label()
        lb.text = "Settings"
        return lb
    }()
    
    override func collectionViewBehaviour() {
        collectionView.register(SettingsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: baseCellId)
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(viewTitleLabel)
        
        NSLayoutConstraint.activate([
            // View Title label
            viewTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            viewTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            viewTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
            
            // CollectionView
            collectionView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 48),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])

    }
}
