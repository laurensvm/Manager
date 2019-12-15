//
//  PhotoViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoViewController: CollectionViewController<PhotoView> {
    
    private let networkManager: NetworkManager
    
    var thumbnails: [ThumbnailImage] = [] {
        didSet {
            DispatchQueue.main.async {
                self.v.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Photos"
        
        populateBreadCrumbTrail()
    }
    
    init(withNetworkManager networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateBreadCrumbTrail() {
        self.navigationController?.viewControllers.forEach({
            if let viewController = $0 as? BreadCrumbViewController {
        	self.v.breadCrumbTrail.append(viewController.getViewControllerTitle())
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnails.count
    }
    
    override func collectionViewBehaviour() {
        self.collectionViewSpacing = 8
    }
	
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.v.baseCellId, for: indexPath) as! PhotoCell
        
        let thumbnail = thumbnails[indexPath.item]
        
        cell.imageView.image = thumbnail.image
        
        if thumbnail.image == nil && !thumbnail.isFetching {
            self.collectionView(collectionView, prefetchItemsAt: [indexPath])
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.v.frame.width - 4 * 8) / 3
        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.v.headerId, for: indexPath) as! CollectionViewHeader
        header.breadCrumb.attributedText = self.formatBreadCrumb(withTrail: v.breadCrumbTrail)
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoPageViewController = PhotoPageViewController(withNetworkManager: networkManager, andThumbnails: thumbnails, currentIndex: indexPath.item)
        
        self.navigationController?.pushViewController(photoPageViewController, animated: true)
        
//        let thumbnail = thumbnails[indexPath.item]
//
//        let detailPhotoViewController = DetailPhotoViewController(withNetworkManager: self.networkManager, thumbnail: thumbnail)
//        detailPhotoViewController.transitioningDelegate = self
        
//            Change to true for an animation
//        self.present(detailPhotoViewController, animated: true, completion: nil)
        
//        self.navigationController?.pushViewController(detailPhotoViewController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.v.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for idx in indexPaths {
            let thumbnail = thumbnails[idx.item]
            
            if thumbnail.image != nil || thumbnail.isFetching {
                return
            }
            
            thumbnail.isFetching = true
            networkManager.getThumbnailImage(id: thumbnail.id, completion: { data in
                thumbnail.image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.v.collectionView.reloadItems(at: [idx])
                }
                
            })
        }
    }
    
}

//extension PhotoViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return transition
//    }
//}
