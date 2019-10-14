//
//  Credentials.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

class Credentials: URLCredential {
    var token: Token?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
