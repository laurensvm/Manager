//
//  NetworkingManager.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 13/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkingManager: NSObject {
    
//    private let environmentBaseURL: String = "https://httpbin.org/basic-auth/user/passwd/"
    private let environmentBaseURL: String = "http://127.0.0.1:5000/"
    
    private var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("Unable to configure base URL") }
        return url
    }
    
    override init() {
        super.init()
        
        let username = "theexission@gmail.com"
        let password = "passwd01"
        
        let headers: HTTPHeaders = [
        	"Authorization": BasicAuthEncoding.encode(username: username, andPassword: password),
        	"Content-Type": "application/json"
        ]
        
    }
}
