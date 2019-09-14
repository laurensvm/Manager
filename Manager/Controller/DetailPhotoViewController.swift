//
//  DetailPhotoViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DetailPhotoViewController: ViewController<DetailPhotoView> {
    
    private var image: UIImage?
    private var navigationsBarsAreHidden: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.didLoadDelegate()
        customView.imageView.image = image
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailPhotoViewController: DetailPhotoDelegate {
    @objc func didTapView(_ sender: UITapGestureRecognizer?) {
        if navigationsBarsAreHidden {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        navigationsBarsAreHidden = !navigationsBarsAreHidden
    }
    
    @objc func didSwipeUp(_ sender: UISwipeGestureRecognizer?) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        customView.didSwipeUp()
    }
    
    @objc func didSwipeDown(_ sender: UISwipeGestureRecognizer?) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        customView.didSwipeDown()
    }
}
