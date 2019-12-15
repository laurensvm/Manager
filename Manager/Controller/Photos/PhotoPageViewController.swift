//
//  PhotoPageContainerViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 15/12/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoPageViewController: UIPageViewController {
    
    private lazy var pages: [DetailPhotoViewController] = {
        return self.thumbnails.map({
            DetailPhotoViewController(withNetworkManager: self.networkManager, thumbnail: $0)
        })
    }()
    
    private var currentIndex: Int
    private var thumbnails: [ThumbnailImage]
    private let networkManager: NetworkManager
    
    init(withNetworkManager networkManager: NetworkManager, andThumbnails thumbnails: [ThumbnailImage], currentIndex: Int) {
        self.networkManager = networkManager
        self.thumbnails = thumbnails
        self.currentIndex = currentIndex
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
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
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? DetailPhotoViewController,
            let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
    
    
}
