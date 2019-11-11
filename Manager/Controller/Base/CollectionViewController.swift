//
//  CollectionViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 11/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class CollectionViewController<V: CollectionView>: ViewController<V>, CollectionViewDelegate {
    
    var items: [[CollectionViewItem]] {
        get {
            return [[]]
        }
    }
    
    var collectionViewCellHeight: CGFloat = 82
    var collectionViewSpacing: CGFloat = 16
    var collectionViewInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.delegate = self
        customView.didLoadDelegate()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        collectionViewBehaviour()
    }
    
    func collectionViewBehaviour() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This method is optional
    func collectionViewHeight() -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.customView.baseCellId, for: indexPath) as! CollectionViewCell
		
        cell.item = items[indexPath.section][indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.customView.frame.width - 4 * collectionViewSpacing, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionViewInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
}

