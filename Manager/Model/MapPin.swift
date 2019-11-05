//
//  MapPin.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 05/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
