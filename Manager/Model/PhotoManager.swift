//
//  PhotoManager.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import Photos

class PhotoManager: NSObject {
    
    override init() {
        super.init()
        
        NetworkingManager()
    }
    
    func beginImportingAssets() {
        
        let images = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        let videos = PHAsset.fetchAssets(with: PHAssetMediaType.video, options: nil)
        
//        let manager = PHImageManager.default()
//      let options = PHImageRequestOptions()
        
        images.enumerateObjects { (image, index, _) in
//            print(image.localIdentifier)
        }
        
        videos.enumerateObjects { (video, index, _) in
            print(video.localIdentifier)
            print(video.duration)
            print(video.playbackStyle)
        }
        
//        assets.enumerateObjects({(object, count, stop) in
//            print(object.localIdentifier)
//            print(object.pixelWidth, object.pixelHeight)
//            print(object.creationDate)
//            print(object.location?.coordinate ?? "")
            //            manager.requestImage(for: object, targetSize: CGSize(width: object.pixelWidth, height: object.pixelHeight), contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
            //                if let im = image {
            //                    print(im.pngData())
            //                    print(im)
            //                    print(im.jpegData(compressionQuality: 1))
            //                }
            //                print(info)
            //            })
//        })
        
//        print(assets)
    }
    
}
