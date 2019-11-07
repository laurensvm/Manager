//
//  AppConfig.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 04/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation


struct AppConfig {
    
    static let baseURL: String = "https://api.vanmieghem.me"
    static let protectionSpace = URLProtectionSpace(
                host: "api.vanmieghem.me",
    			port: 443,
    			protocol: "https",
    			realm: nil,
    			authenticationMethod: NSURLAuthenticationMethodHTTPBasic
    )
    
}
