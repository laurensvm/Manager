//
//  PhotoViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoViewController: ViewController<PhotoView> {
    
    private var networkManager: NetworkManager?
    
    private let transition = DetailViewTransition()
    
    var images: [Image] = [] {
        didSet {
            DispatchQueue.main.async {
                self.customView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Photos"
        
        // Setup datasources and delegates
        customView.delegate = self
        customView.didLoadDelegate()
        customView.collectionView.prefetchDataSource = self
        
        populateBreadCrumbTrail()
    }
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
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
}

extension PhotoViewController: CollectionViewDelegate {
    func collectionViewHeight() -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.customView.photoCellId, for: indexPath) as! PhotoCell
        
        let image = images[indexPath.item]
        
        cell.imageView.image = image.image
        
        if image.image == nil && !image.isFetching {
            self.collectionView(collectionView, prefetchItemsAt: [indexPath])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.customView.frame.width - 4 * 8) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.customView.headerId, for: indexPath) as! CollectionViewHeader
        header.breadCrumb.attributedText = self.formatBreadCrumb(withTrail: customView.breadCrumbTrail)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.customView.frame.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    	
        if let cell = collectionView.cellForItem(at: indexPath) {
            transition.originFrame = cell.frame
        }
        
        // Animation        
        if let image = images[indexPath.item].image {
            let detailPhotoViewController = DetailPhotoViewController(image: image)
            detailPhotoViewController.transitioningDelegate = self
            
//            Change to true for an animation
//            self.present(detailPhotoViewController, animated: true, completion: nil)
            
            self.navigationController?.pushViewController(detailPhotoViewController, animated: true)

        }
        
    }
    
}

extension PhotoViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
}

extension PhotoViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for idx in indexPaths {
            let image = images[idx.item]
            guard let imageURL = image.imageURL,
                 image.image == nil,
                !image.isFetching else { return }
            
            image.isFetching = true
            networkManager?.getImage(url: imageURL, completion: { data in
                image.image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.customView.collectionView.reloadItems(at: [idx])
                }
                
            })
        }
    }
    
    
}
