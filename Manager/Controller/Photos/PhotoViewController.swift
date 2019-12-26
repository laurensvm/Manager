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
    private var currentIndexPath: IndexPath!
    
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
        
        self.currentIndexPath = indexPath
        
        let photoPageViewController = PhotoPageViewController(withNetworkManager: networkManager, andThumbnails: thumbnails, currentIndex: currentIndexPath.item)
        self.navigationController?.delegate = photoPageViewController.transitionController
        
        photoPageViewController.transitionController.fromDelegate = self
        photoPageViewController.transitionController.toDelegate = photoPageViewController
        photoPageViewController.pageDelegate = self
        
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
    
    func getImageViewFromCollectionViewCell() -> UIImageView {
        
        //Get the array of visible cells in the collectionView
        let visibleCells = self.v.collectionView.indexPathsForVisibleItems
        
        //If the current indexPath is not visible in the collectionView,
        //scroll the collectionView to the cell to prevent it from returning a nil value
        if !visibleCells.contains(self.currentIndexPath) {
           
            //Scroll the collectionView to the current selectedIndexPath which is offscreen
            self.v.collectionView.scrollToItem(at: self.currentIndexPath, at: .centeredVertically, animated: false)
            
            //Reload the items at the newly visible indexPaths
            self.v.collectionView.reloadItems(at: self.v.collectionView.indexPathsForVisibleItems)
            self.v.collectionView.layoutIfNeeded()
            
            //Guard against nil values
            guard let guardedCell = (self.v.collectionView.cellForItem(at: self.currentIndexPath) as? PhotoCell) else {
                //Return a default UIImageView
                return UIImageView(frame: CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 100.0, height: 100.0))
            }
            //The PhotoCollectionViewCell was found in the collectionView, return the image
            return guardedCell.imageView
        }
        else {
            
            //Guard against nil return values
            guard let guardedCell = self.v.collectionView.cellForItem(at: self.currentIndexPath) as? PhotoCell else {
                //Return a default UIImageView
                return UIImageView(frame: CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 100.0, height: 100.0))
            }
            //The PhotoCollectionViewCell was found in the collectionView, return the image
            return guardedCell.imageView
        }
        
    }
    
    func getFrameFromCollectionViewCell() -> CGRect {
        
        //Get the currently visible cells from the collectionView
        let visibleCells = self.v.collectionView.indexPathsForVisibleItems
        
        //If the current indexPath is not visible in the collectionView,
        //scroll the collectionView to the cell to prevent it from returning a nil value
        if !visibleCells.contains(self.currentIndexPath) {
            
            //Scroll the collectionView to the cell that is currently offscreen
            self.v.collectionView.scrollToItem(at: self.currentIndexPath, at: .centeredVertically, animated: false)
            
            //Reload the items at the newly visible indexPaths
            self.v.collectionView.reloadItems(at: self.v.collectionView.indexPathsForVisibleItems)
            self.v.collectionView.layoutIfNeeded()
            
            //Prevent the collectionView from returning a nil value
            guard let guardedCell = (self.v.collectionView.cellForItem(at: self.currentIndexPath) as? PhotoCell) else {
                return CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 100.0, height: 100.0)
            }
            
            let cell = CGRect(x: guardedCell.frame.origin.x, y: guardedCell.frame.origin.y + 64, width: guardedCell.frame.size.width, height: guardedCell.frame.size.height)
            return cell
        } else {
            //Prevent the collectionView from returning a nil value
            guard let guardedCellAttributes = self.v.collectionView.layoutAttributesForItem(at: self.currentIndexPath) else {
                return CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 100.0, height: 100.0)
            }
            //The cell was found successfully
            let cell = CGRect(x: guardedCellAttributes.frame.origin.x,
                              y: guardedCellAttributes.frame.origin.y + 64,
                              width: guardedCellAttributes.frame.size.width,
                              height: guardedCellAttributes.frame.size.height
            )
            return cell
        }
    }
    
}

extension PhotoViewController: PhotoDetailViewTransitionDelegate {
    func transitionWillStartWith(animator: PhotoDetailViewTransition) {}
    
    func transitionDidEndWith(animator: PhotoDetailViewTransition) {
        let cell = self.v.collectionView.cellForItem(at: self.currentIndexPath) as! PhotoCell
        
        let cellFrame = self.v.collectionView.convert(cell.frame, to: self.v)
        
        if cellFrame.minY < self.v.collectionView.contentInset.top {
            self.v.collectionView.scrollToItem(at: self.currentIndexPath, at: .top, animated: false)
        } else if cellFrame.maxY > self.view.frame.height - self.v.collectionView.contentInset.bottom {
            self.v.collectionView.scrollToItem(at: self.currentIndexPath, at: .bottom, animated: false)
        }
    }
    
    func referenceImageView(for animator: PhotoDetailViewTransition) -> UIImageView? {
        return getImageViewFromCollectionViewCell()
    }
    
    func referenceImageViewFrameInTransitioningView(for animator: PhotoDetailViewTransition) -> CGRect? {
        self.v.layoutIfNeeded()
        self.v.collectionView.layoutIfNeeded()
        
        // Get a guarded reference to the cell's frame
        let unconvertedFrame = getFrameFromCollectionViewCell()

        let cellFrame = self.v.collectionView.convert(unconvertedFrame, to: self.v)
        
        if cellFrame.minY < self.v.collectionView.contentInset.top {
            return CGRect(x: cellFrame.minX, y: self.v.collectionView.contentInset.top, width: cellFrame.width, height: cellFrame.height - (self.v.collectionView.contentInset.top - cellFrame.minY))
        }
        
        return cellFrame
    }
}

extension PhotoViewController: PhotoPageViewControllerDelegate {
 
    func containerViewController(_ containerViewController: PhotoPageViewController, indexDidUpdate currentIndex: Int) {
        self.currentIndexPath = IndexPath(row: currentIndex, section: 0)
        self.v.collectionView.scrollToItem(at: self.currentIndexPath, at: .centeredVertically, animated: false)
    }
}
