//
//  Token.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 04/08/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public struct Token: Decodable {
    let expiration: Int
    let token: String
    let date: Date = Date()
}
