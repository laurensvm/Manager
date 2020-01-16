//
//  RecentViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 16/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class RecentViewController: CollectionViewController<RecentView> {
    
    var networkManager: NetworkManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Recent"
        v.delegate = self
        v.didLoadDelegate()
        
        self.collectionViewSpacing = 16.0
    }
    
    init(withNetworkManager networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionViewHeight() -> CGFloat {
        return CGFloat(items.flatMap({ $0 }).count) * (collectionViewCellHeight + collectionViewSpacing) + 32
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let vc = PhotoViewController(withNetworkManager: networkManager)
            networkManager.getImageListIds(amount: 100, completion: { (thumbnails, error) in
                if let thumbnails = thumbnails {
                    vc.thumbnails = thumbnails
                }
            })
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
