//
//  DetailPhotoViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit
import CoreLocation

class DetailPhotoViewController: ViewController<DetailPhotoView> {
    
    private var networkManager: NetworkManager?
    
    private var image: Image? {
        didSet {
            if let _ = image?.imageData {
                self.customView.image = image
            }
            
            if let coords = image?.coordinates {
                self.customView.mapPin = self.generateMapPin(coords)
            }
        }
    }
    private var thumbnail: ThumbnailImage!
    private var navigationsBarsAreHidden: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    private func generateMapPin(_ coords: CLLocationCoordinate2D) -> MapPin {
        return MapPin(coordinate: coords, title: "Image", subtitle: "Image")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.didLoadDelegate()
        
        if let im = self.image?.imageData {
            image?.imageData = im
        }
        image?.imageData = thumbnail.image
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    init(withNetworkManager networkManager: NetworkManager?, thumbnail: ThumbnailImage) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
        self.thumbnail = thumbnail
        self.image = Image()
        
        fetchImage()
        fetchImageDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchImage() {
        networkManager?.getImage(id: thumbnail.id, completion: { data in
            DispatchQueue.main.async {
            	self.image?.imageData = UIImage(data: data)
            }
        })
    }
    
    private func fetchImageDetails() {
        networkManager?.getImageDetails(id: thumbnail.id, completion: { data, error in
            if let error = error {
                // Do something with the error
                print(error)
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image?.append(data)
                }
            }
        })
    }
    
}

extension DetailPhotoViewController: DetailPhotoDelegate {
    @objc func didTapView(_ sender: UITapGestureRecognizer?) {
        if !customView.detailsViewIsActive {
            if navigationsBarsAreHidden {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            } else {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
            navigationsBarsAreHidden = !navigationsBarsAreHidden
        }
    }
    
    @objc func didSwipeUp(_ sender: UISwipeGestureRecognizer?) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        customView.didSwipeUp()
    }
    
    @objc func didSwipeDown(_ sender: UISwipeGestureRecognizer?) {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        customView.didSwipeDown()
    }
}
