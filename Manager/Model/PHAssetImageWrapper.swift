//
//  PHAssetImageWrapper.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 05/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

struct PHAssetImageWrapper {
    let image: UIImage
    let name: String
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
}
