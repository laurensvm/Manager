//
//  PhotoManager.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import Photos

class PhotoManager: NSObject, PHPhotoLibraryChangeObserver {
    
    private var networkManager: NetworkManager!
    private var imageManager: PHImageManager!
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init()
        self.networkManager = networkManager
        self.imageManager = PHImageManager.default()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == PHAuthorizationStatus.authorized {
                PHPhotoLibrary.shared().register(self)
                print("Access Granted and \(self) registered")
            }
        }
        
        print("Setup")
    }
    
    func beginImportingAssets() {
        
        let imageAssets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
//        let videos = PHAsset.fetchAssets(with: PHAssetMediaType.video, options: nil)
        
        imageAssets.enumerateObjects { (asset, index, _) in
            if index == 0 {
                print("Processing Image \(index)")
                self.processImage(asset: asset)
            }
        }
        
//        videos.enumerateObjects { (video, index, _) in
//            print(video.localIdentifier)
//            print(video.duration)
//            print(video.playbackStyle)
//        }
        
        print("Imported")
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            print("WWWWW")
        }
        print("DID CHANGE MONNN")
    }
    
    private func processImage(asset: PHAsset) {
        
        var parameters: Parameters = [:]
        
        parameters["local_id"] = asset.localIdentifier
        parameters["directory_id"] = 1
        
        if let lat = asset.location?.coordinate.latitude,
            let lon = asset.location?.coordinate.latitude {
            parameters["latitude"] = Double(lat)
            parameters["longitude"] = Double(lon)
        }
        
        
        let name = PHAssetResource.assetResources(for: asset).first?.originalFilename ?? UUID().uuidString
        
        self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil, resultHandler: { (image, info) in
            
            guard let image = image else { return }
            
            parameters["file"] = PHAssetImageWrapper(image: image, name: name)
            print(parameters)
            print(asset.pixelWidth, asset.pixelHeight)
            self.networkManager.uploadImage(parameters: parameters, completion: { json, error in                
                print("Request Completed")
            })
        })
    }
}

