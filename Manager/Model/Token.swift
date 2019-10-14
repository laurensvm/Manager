//
//  Token.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 04/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public struct Token: Codable {
    let expiration: Int
    let string: String
    let date: Date = Date()
    
    enum CodingKeys: String, CodingKey {
        case string = "token"
        case expiration
    }
    
    func isExpired() -> Bool {
    	if Int(date.timeIntervalSinceNow) > expiration {
            return true
        }
        return false
    }
    
    func willExpireInLessThanAMinute() -> Bool {
        if Int(date.timeIntervalSinceNow) > expiration - 60 {
            return true
        }
        return false
    }
}
