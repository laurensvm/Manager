//
//  PhotoPageContainerViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 15/12/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoPageViewController: UIPageViewController {
    
    private lazy var pages: [DetailPhotoViewController] = {
        return self.thumbnails.map({
            DetailPhotoViewController(withNetworkManager: self.networkManager, thumbnail: $0)
        })
    }()
    
    private var currentIndex: Int
    private var thumbnails: [ThumbnailImage]
    private let networkManager: NetworkManager
    
    var transitionController = PhotoDetailViewTransitionController()
    weak var pageDelegate: PhotoPageViewControllerDelegate?
    
    init(withNetworkManager networkManager: NetworkManager, andThumbnails thumbnails: [ThumbnailImage], currentIndex: Int) {
        self.networkManager = networkManager
        self.thumbnails = thumbnails
        self.currentIndex = currentIndex
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing: 8])
        
        self.dataSource = self
        self.delegate = self
        
        self.setViewControllers([pages[self.currentIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoPageViewController: UIPageViewControllerDelegate {
    
}

extension PhotoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? DetailPhotoViewController,
            let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        
        self.currentIndex = previousIndex
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? DetailPhotoViewController,
            let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        
        self.currentIndex = nextIndex
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.pageDelegate?.containerViewController(self, indexDidUpdate: self.currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let nextVC = pendingViewControllers.first as? DetailPhotoViewController,
            let index = pages.firstIndex(of: nextVC) else { return }
        
        self.currentIndex = index
    }
    
}

extension PhotoPageViewController: PhotoDetailViewTransitionDelegate  {
    func transitionWillStartWith(animator: PhotoDetailViewTransition) {
        
    }
    
    func transitionDidEndWith(animator: PhotoDetailViewTransition) {
        
    }
    
    func referenceImageView(for animator: PhotoDetailViewTransition) -> UIImageView? {
        return self.pages[currentIndex].v.imageView
    }
    
    func referenceImageViewFrameInTransitioningView(for animator: PhotoDetailViewTransition) -> CGRect? {
        let currentVCView = self.pages[currentIndex].v
        
        let imageView = currentVCView.imageView
        guard let image = imageView.image else {
            return currentVCView.convert(imageView.frame, to: currentVCView)
        }
        
        let imageRect = AVMakeRect(aspectRatio: image.size, insideRect: imageView.bounds)
        
        // Dirty workaround because tabBar shifts the view up
        let shiftedRect = CGRect(x: imageRect.origin.x,
                          y: imageRect.origin.y + 64,
                          width: imageRect.size.width,
                          height: imageRect.size.height
        )
        
        return shiftedRect
        
    }
    
    
}
