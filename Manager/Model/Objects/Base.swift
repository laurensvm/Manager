//
//  Base.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

class Base: NSObject {
    
    var id: Int!
    var updated: Date?
    var timestamp: Date?
    
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
        return Base.dateFormatter.date(from: dateString)
    }
    
    func append(_ json: JSON) {
        self.id = json["id"].intValue
        self.timestamp = createDateObject(dateString: json["timestamp"].string)
        self.updated = createDateObject(dateString: json["updated"].string)
    }
}
