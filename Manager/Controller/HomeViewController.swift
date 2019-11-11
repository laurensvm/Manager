//
//  HomeViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class HomeViewController: CollectionViewController<HomeView> {
    
    var networkManager: NetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.controllerTitle = "Home"
        customView.delegate = self
        customView.didLoadDelegate()
        
        self.collectionViewSpacing = 16.0
    }
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init()
        self.networkManager = networkManager
    }
    
    override func collectionViewBehaviour() {
        self.items = [[
            HomeViewTab(name: "Photos", imageName: "photos", capacity: 40, size: 19),
            HomeViewTab(name: "Videos", imageName: "videos", capacity: 20, size: 5),
            HomeViewTab(name: "Music", imageName: "music", capacity: 30, size: 28)
        ]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionViewHeight() -> CGFloat {
        return CGFloat(items.flatMap({ $0 }).count) * (collectionViewCellHeight + collectionViewSpacing) + 32
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            if let networkManager = self.networkManager {
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
}
