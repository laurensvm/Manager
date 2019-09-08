//
//  UserDefaults.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setLoggedInStatus(value: Bool) {
        set(value, forKey: "LoggedIn")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "LoggedIn")
    }
    
    func setUserProperties(credentials: Credentials) {
        set(credentials.username, forKey: "username")
        set(credentials.password, forKey: "password")
        setToken(token: credentials.token)
        synchronize()
    }
    
    func getUserProperties() throws -> Credentials {
        guard let username = string(forKey: "username"),
            let password = string(forKey: "password") else {
                // TO BE IMPLEMENTED
//                fatalError("Implement me (LoginViewController should appear)")
                return Credentials(username: "theexission@gmail.com", password: "passwd01", token: nil)
        }
        let token = getToken()
        
        return Credentials(username: username, password: password, token: token)
    }
    
    func getToken() -> Token? {
        guard let token = string(forKey: "token-value") else { return nil }
        let expiration = integer(forKey: "token-expiration")
        return Token(expiration: expiration, token: token)
    }
    
    func setToken(token: Token?) {
        if let token = token {
            set(token.expiration, forKey: "token-expiration")
            set(token.token, forKey: "token-value")
            synchronize()
        }
    }
}
