//
//  Session.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

struct Session {
    
    static var shared = Session()
    
    private init() {}
    
    var user: User? {
        didSet {
            print(self.user)
        }
    }
}
