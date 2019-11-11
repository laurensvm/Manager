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
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Settings"
        return lb
    }()
    
    override func collectionViewBehaviour() {
        self.collectionView.register(SettingsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        self.collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: baseCellId)
    }
    
    override func setupViews() {
        super.setupViews()
        self.addSubview(viewTitleLabel)
        
        // View Title label
        self.viewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.viewTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        self.viewTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
        
        self.collectionView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 48).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
    }
}
