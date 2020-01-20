//
//  HomeViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class HomeViewController: CollectionViewController<HomeView> {
    
    var networkManager: NetworkManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.controllerTitle = "Home"
        v.delegate = self
        v.didLoadDelegate()
        
        self.collectionViewSpacing = 16.0
    }
    
    init(withNetworkManager networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init()
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
            let vc = PhotoViewController(withNetworkManager: networkManager)
            networkManager.getImageListIds(amount: 100, completion: { (thumbnails, error) in
                if let thumbnails = thumbnails {
                    vc.thumbnails = thumbnails
                }
            })
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 1 {
            let vc = VideoViewController(withNetworkManager: networkManager)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = MusicViewController(withNetworkManager: networkManager)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
