//
//  User.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: Base {
    var admin: Bool = false
    var email: String!
    var username: String!
    var directoryRights: [String] = []
    var files: [String] = []
    
    override func append(_ json: JSON) {
        super.append(json)
        self.admin = json["admin"].boolValue
        self.email = json["email"].stringValue
        self.username = json["username"].stringValue
        self.files = json["files"].arrayValue.map({ $0.stringValue })
        self.directoryRights = json["directory_rights"].arrayValue.map({ $0.stringValue })
    }
}
