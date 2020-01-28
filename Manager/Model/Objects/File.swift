//
//  File.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 20/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import SwiftyJSON

class File: Base, CollectionViewItem {
    
    public enum _Type: String {
        case image = "image"
        case pdf = "pdf"
        case video = "video"
        case txt = "txt"
        case unknown = "unknown"
    }
    
    var type: _Type?
    var _description: String?
    var directoryId: Int?
    var userId: Int?
    var name: String!
    var ext: String?
    var path: String!
    var size: Int?
    
    init(_ json: JSON) {
        super.init()
        append(json)
    }
    
    override func append(_ json: JSON) {
        super.append(json)
        self.type = _Type(rawValue: json["type"].stringValue)
        self._description = json["description"].string
        self.name = json["name"].stringValue
        self.ext = json["extension"].string
        self.directoryId = json["directory_id"].int
        self.userId = json["user_id"].int
        self.path = json["path"].stringValue
        self.size = json["size"].int
    }
}
