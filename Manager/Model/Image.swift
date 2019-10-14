//
//  Image.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import UIKit

class Image {
    var size: Int!
    var imageURL: String!
    var image: UIImage!
    var isFetching: Bool = false
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        size = try container.decode(Int.self, forKey: .size)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        
    }
}

extension Image: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case size
        case imageURL = "image_url"
    }
}
