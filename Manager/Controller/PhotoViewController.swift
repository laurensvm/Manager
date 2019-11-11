//
//  PhotoViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoViewController: CollectionViewController<PhotoView> {
    
    private var networkManager: NetworkManager!
    
    private let transition = DetailViewTransition()
    
    var thumbnails: [ThumbnailImage] = [] {
        didSet {
            DispatchQueue.main.async {
                self.customView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Photos"
        
        populateBreadCrumbTrail()
    }
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init()
        self.networkManager = networkManager
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateBreadCrumbTrail() {
        self.navigationController?.viewControllers.forEach({
            if let viewController = $0 as? BreadCrumbViewController {
        	self.customView.breadCrumbTrail.append(viewController.getViewControllerTitle())
            }
        })
    }
	
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.customView.baseCellId, for: indexPath) as! PhotoCell
        
        let thumbnail = thumbnails[indexPath.item]
        if thumbnail.image == nil && !thumbnail.isFetching {
            self.collectionView(collectionView, prefetchItemsAt: [indexPath])
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.customView.frame.width - 4 * 8) / 3
        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.customView.headerId, for: indexPath) as! CollectionViewHeader
        header.breadCrumb.attributedText = self.formatBreadCrumb(withTrail: customView.breadCrumbTrail)
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    	
        if let cell = collectionView.cellForItem(at: indexPath) {
            transition.originFrame = cell.frame
        }
        
        let thumbnail = thumbnails[indexPath.item]
        
        let detailPhotoViewController = DetailPhotoViewController(withNetworkManager: self.networkManager, thumbnail: thumbnail)
        detailPhotoViewController.transitioningDelegate = self
        
//            Change to true for an animation
//            self.present(detailPhotoViewController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(detailPhotoViewController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.customView.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for idx in indexPaths {
            let thumbnail = thumbnails[idx.item]
            
            if thumbnail.image != nil || thumbnail.isFetching {
                return
            }
            
            thumbnail.isFetching = true
            networkManager?.getThumbnailImage(id: thumbnail.id, completion: { data in
                thumbnail.image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.customView.collectionView.reloadItems(at: [idx])
                }
                
            })
        }
    }
    
}

extension PhotoViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
