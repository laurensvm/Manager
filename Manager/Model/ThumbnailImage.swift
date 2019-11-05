//
//  Image.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import UIKit

class ThumbnailImage {
    var id: Int
    var image: UIImage!
    var isFetching: Bool = false
    
    init(id: Int) {
        self.id = id
    }
}
