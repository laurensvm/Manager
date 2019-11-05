//
//  PHAssetImageWrapper.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 05/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

struct PHAssetImageWrapper {
    
    enum ExtensionType: String {
        case JPG = "JPG"
        case HEIC = "HEIC"
        case PNG = "PNG"
    }
    
    let image: UIImage
    let name: String
    let type: ExtensionType
    
    init(image: UIImage, name: String) {
        self.image = image
        self.type = PHAssetImageWrapper.getExtensionType(name)
        self.name = name.fileName() + "." + ExtensionType.JPG.rawValue
    }
    
    public static func getExtensionType(_ name: String) -> ExtensionType {
        switch name.fileExtension().uppercased() {
        case "PNG":
            return .PNG
        case "HEIC":
            return .HEIC
        default:
            return .JPG
    	}
    }
}
