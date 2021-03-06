//
//  CredentialManager.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 14/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

class CredentialManager: NSObject {
    
    // Used to do periodic requests to get a token
    private var timer = Timer()
    private let expirationTime: Double = 3000
    
    private let storage = URLCredentialStorage.shared
    
    var delegate: NetworkManager?
    
    private var token: Token?
    
    private let protectionSpace = AppConfig.protectionSpace
    
    override init() {
        super.init()
        setupTokenRefreshTimer()
        
    }
    
    private func setupTokenRefreshTimer() {
        timer = Timer.scheduledTimer(timeInterval: self.expirationTime, target: self, selector: #selector(self.refreshTokenIfNeeded), userInfo: nil, repeats: true)
    }
    
    @objc func refreshTokenIfNeeded() {
        if hasValidCredentials() {
            if tokenWillExpireInLessThanAMinute() {
                delegate?.getToken(completion: { error, token in
                    if error != nil {
                        print("Error: \(error!)")
                    }
                    
                    if let token = token {
                        self.token = token
                    }
                })
            }
        } else {
            // We should go back to the LoginViewController
            print("No valid credentials")
        }
    }
    
    func setCredentials(username: String, password: String) {
        let credentials = URLCredential(user: username, password: password, persistence: .permanent)
        storage.setDefaultCredential(credentials, for: protectionSpace)
        
        refreshTokenIfNeeded()
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, String?) -> ()) {
        
        setCredentials(username: username, password: password)
        
        delegate?.getToken(completion: { error, token in
            if error != nil {
                completion(false, error)
            }
            
            if let token = token {
                self.token = token
                self.getUserObject()
                completion(true, nil)
            } else {
                completion(false, error)
            }
            
        })
    }
    
    private func getUserObject() {
        guard let username = storage.defaultCredential(for: protectionSpace)?.user else { return }
        delegate?.getUser(byUsername: username, completion: { user, error in
            Session.shared.user = user
        })
    }
    
    func getCredentials() -> URLCredential? {
        guard let credentials = storage.defaultCredential(for: protectionSpace) else { return nil }
        return credentials
    }
    
    func removeCredentials() {
        guard let credentials = storage.defaultCredential(for: protectionSpace) else { return }
        storage.remove(credentials, for: protectionSpace)
    }
    
    func getTokenString() -> String? {
        guard let tokenString = token?.string else { return nil }
        return tokenString
    }
    
    func updateToken(token: Token) {
        self.token = token
    }
    
    func tokenIsExpired() -> Bool {
        if let token = token {
            return token.isExpired()
        }
        return true
    }
    
    func tokenWillExpireInLessThanAMinute() -> Bool {
        if let token = token {
            return token.willExpireInLessThanAMinute()
        }
        return true
    }
    
    func hasValidCredentials() -> Bool {
        if let _ = storage.defaultCredential(for: protectionSpace) {
            return true
        }
        return false
    }
    
    func signOut() {
        self.removeCredentials()
        Session.shared.user = nil
        
    }
}
