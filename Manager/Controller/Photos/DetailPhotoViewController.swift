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
    
    private let networkManager: NetworkManager
    
    private var image: Image {
        didSet {
            self.v.image = image
            
            if let coords = image.coordinates {
                self.v.mapPin = self.generateMapPin(coords)
            }
        }
    }
    private var thumbnail: ThumbnailImage
    private var navigationsBarsAreHidden: Bool = false
    
    private func generateMapPin(_ coords: CLLocationCoordinate2D) -> MapPin {
        return MapPin(coordinate: coords, title: "Image", subtitle: "Image")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        v.delegate = self
        v.didLoadDelegate()
        
        if let im = self.image.imageData {
            image.imageData = im
        }
        image.imageData = thumbnail.image
        
    }
    
    init(withNetworkManager networkManager: NetworkManager, thumbnail: ThumbnailImage) {
        self.networkManager = networkManager
        self.thumbnail = thumbnail
        self.image = Image()
        super.init()
        
        fetchImage()
        fetchImageDetails()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchImage() {
        networkManager.getImage(id: thumbnail.id, completion: { data in
            DispatchQueue.main.async {
            	self.image.imageData = UIImage(data: data)
            }
        })
    }
    
    private func fetchImageDetails() {
        networkManager.getImageDetails(id: thumbnail.id, completion: { data, error in
            if let error = error {
                // Do something with the error
                print(error)
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image.append(data)
                }
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if self.v.detailsViewIsActive {
            self.v.didSwipeDown()
        }
        
        super.viewWillAppear(animated)
    }
    
}

extension DetailPhotoViewController: DetailPhotoDelegate {
    @objc func didTapView(_ sender: UITapGestureRecognizer?) {
        if !v.detailsViewIsActive {
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
        v.didSwipeUp()
    }
    
    @objc func didSwipeDown(_ sender: UISwipeGestureRecognizer?) {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        v.didSwipeDown()
    }
}

