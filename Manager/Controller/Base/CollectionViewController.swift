//
//  CollectionViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 11/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class CollectionViewController<V: CollectionView>: ViewController<V>, CollectionViewDelegate {

    internal var items: [[CollectionViewItem]] = [[]] {
        didSet {
            DispatchQueue.main.async {
                self.customView.collectionView.reloadData()
            }
        }
    }
    
    internal var collectionViewCellHeight: CGFloat = 82
    internal var collectionViewSpacing: CGFloat = 16
    internal var collectionViewInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.delegate = self
        customView.didLoadDelegate()
        customView.collectionView.prefetchDataSource = self
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        collectionViewBehaviour()
    }
    
    func collectionViewBehaviour() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Datasource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.customView.baseCellId, for: indexPath) as! CollectionViewCell
		
        cell.item = items[indexPath.section][indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {}
    
    
    // Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.customView.frame.width - 4 * collectionViewSpacing, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionViewInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    
    // This method is optional
    func collectionViewHeight() -> CGFloat {
        return 0
    }
    
}

