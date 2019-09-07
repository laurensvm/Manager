//
//  BasicAuthEncoding.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

struct BasicAuthEncoding {
	static func encode(username: String, andPassword password: String) -> String {
        let loginData = "\(username):\(password)".data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        return "Basic \(base64LoginData)"
    }
}
