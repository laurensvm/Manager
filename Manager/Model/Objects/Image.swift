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

struct Image {
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
    var id: Int!
    var updated: Date?
    var timestamp: Date?
    
    mutating func append(_ json: JSON) {
        self.coordinates = Base().createCoordinates(coordinates: json["coordinates"])
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
        self.id = json["id"].intValue
        self.timestamp = createDateObject(dateString: json["timestamp"].string)
        self.updated = createDateObject(dateString: json["updated"].string)
    }
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "E, d MMM yyyy HH:mm:ss zzz"
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
    
    func createCoordinates(coordinates: JSON) -> CLLocationCoordinate2D? {
        let lat = CLLocationDegrees(coordinates["latitude"].doubleValue)
        let lon = CLLocationDegrees(coordinates["longitude"].doubleValue)
        
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    func createDateObject(dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        return Image.dateFormatter.date(from: dateString)
    }
}
