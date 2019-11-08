//
//  SettingsView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 14/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class SettingsView: View {
    
    var delegate: CollectionViewDelegate?
    let settingsCell = "settingsCell"
    let headerId = "headerId"
    
    private lazy var viewTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Settings"
        return lb
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SettingsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: settingsCell)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didLoadDelegate() {
        self.collectionView.delegate = delegate!
        self.collectionView.dataSource = delegate!
    }
    
    private func setupViews() {
        self.addSubview(viewTitleLabel)
        self.addSubview(collectionView)
        
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
