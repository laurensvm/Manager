//
//  CollectionView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 11/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class CollectionView: View {
    weak var delegate: CollectionViewDelegate!
    var baseCellId = "baseCellId"
    var headerCellId = "headerCellId"
    
    lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = true
        
        collectionViewBehaviour()
        
        setupViews()
    }
    
    func collectionViewBehaviour() {
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: baseCellId)
    }
    
    func didLoadDelegate() {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
    }
    
    func setupViews() {
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
