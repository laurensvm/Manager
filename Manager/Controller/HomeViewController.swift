//
//  HomeViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class HomeViewController: ViewController<HomeView> {
    
    private let categories: [HomeViewTab] = [
        HomeViewTab(name: "Photos", imageName: "photos", capacity: 40, size: 19),
        HomeViewTab(name: "Videos", imageName: "videos", capacity: 20, size: 5),
        HomeViewTab(name: "Music", imageName: "music", capacity: 30, size: 15)
    ]
    private let collectionViewCellHeight: CGFloat = 82
    private let collectionViewSpacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        customView.delegate = self
        customView.didLoadDelegate()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomeViewController: HomeViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.customView.homeViewCellId, for: indexPath) as! HomeViewCell
        
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
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
