//
//  Image.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 05/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class Image: Base {
    var imageData: UIImage?
    var coordinates: CLLocationCoordinate2D?
    var _description: String?
    var device: String?
    var directory: String?
    var _extension: String?
    var localId: String?
    var name: String?
    var path: String?
    var resolution: String?
    var size: Int?
    var user: String?
    var type: String?
    
    override func append(_ json: JSON) {
        super.append(json)
        self.coordinates = createCoordinates(coordinates: json["coordinates"])
        self._description = json["description"].string
        self.device = json["device"].string
        self.directory = json["directory"].string
        self._extension = json["extension"].string
        self.localId = json["local_identifier"].string
        self.name = json["name"].string
        self.path = json["path"].string
        self.resolution = json["resolution"].string
        self.size = json["size"].intValue
        self.type = json["type"].string
    }
}
