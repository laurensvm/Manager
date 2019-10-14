//
//  HomeViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class HomeViewController: ViewController<HomeView> {
    
    var networkManager: NetworkManager?
    
    private let categories: [HomeViewTab] = [
        HomeViewTab(name: "Photos", imageName: "photos", capacity: 40, size: 19),
        HomeViewTab(name: "Videos", imageName: "videos", capacity: 20, size: 5),
        HomeViewTab(name: "Music", imageName: "music", capacity: 30, size: 28)
    ]
    private let collectionViewCellHeight: CGFloat = 82
    private let collectionViewSpacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.controllerTitle = "Home"
        customView.delegate = self
        customView.didLoadDelegate()
        
    }
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomeViewController: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.customView.homeViewCellId, for: indexPath) as! HomeCell
        
        let category = categories[indexPath.item]
        
        cell.title.text = category.name
        cell.storageLabel.text = "\(Int(category.size)) GB"
        cell.progressView.setProgress(category.size / category.capacity, animated: true)
        cell.pictureImageView.image = UIImage(named: category.imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.customView.frame.width - 64, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewSpacing
    }
    
    func collectionViewHeight() -> CGFloat {
        return CGFloat(categories.count) * (collectionViewCellHeight + collectionViewSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            if let networkManager = self.networkManager {
                let vc = PhotoViewController(withNetworkManager: networkManager)
                networkManager.getImageList(amount: 100, completion: { (images, error) in
                    if let images = images {
            			vc.images = images
                    }
                })

                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
