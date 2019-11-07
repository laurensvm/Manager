//
//  Directory.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import SwiftyJSON

class Directory: Base {
    var children: [String]?
    var files: [String]?
    var name: String!
    var parentId: Int?
    var path: String!
    var size: Int?
    var userRights: [String]?
    
    init(_ json: JSON) {
        super.init()
        append(json)
    }
    
    override func append(_ json: JSON) {
        super.append(json)
        self.children = json["children"].arrayValue.map({ $0.stringValue })
        self.files = json["files"].arrayValue.map({ $0.stringValue })
        self.name = json["name"].stringValue
        self.parentId = json["parent_id"].int
        self.path = json["path"].stringValue
        self.size = json["size"].int
        self.userRights = json["users_with_rights"].arrayValue.map({ $0.stringValue })
    }
    
    static func createDirectoryList(_ json: JSON) -> [Directory] {
        var directories: [Directory] = []
        for (_, jsonDir) in json["directories"] {
            directories.append(Directory(jsonDir))
        }
        return directories
    }
}
