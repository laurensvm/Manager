//
//  KeyChain.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

//struct KeyChain {
//    static let user = "User"
//    
//    init() {
//    }
//    
//    static func storeUserCredentialsInKeyChain(credentials: Credentials) throws {
//        
//        // Get username and password
//        let username = credentials.username
//        let password = credentials.password.data(using: String.Encoding.utf8)!
//    
//        
//        let query: [String: Any] = [kSecAttrApplicationTag as String: "tag",
//                                    kSecAttrSubject as String: KeyChain.user,
//                                    kSecAttrAccount as String: username,
//                                    kSecValueData as String: password,
//                                    kSecAttrGeneric as String: credentials.token ?? ""]
//        
//        let status = SecItemAdd(query as CFDictionary, nil)
//        print(status)
//        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
//    }
//    
//    
//    static func retrieveUserCredentialsFromKeyChain() throws -> Credentials {
//        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
//                                    kSecAttrSubject as String: KeyChain.user,
//                                    kSecReturnAttributes as String: true,
//                                    kSecReturnData as String: true]
//        
//        var item: CFTypeRef?
//        let status = SecItemCopyMatching(query as CFDictionary, &item)
//        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
//        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
//        
//        guard let existingItem = item as? [String : Any],
//            let passwordData = existingItem[kSecValueData as String] as? Data,
//            let password = String(data: passwordData, encoding: String.Encoding.utf8),
//            let account = existingItem[kSecAttrAccount as String] as? String
//            else {
//                throw KeychainError.unexpectedPasswordData
//        }
//        
//        let token = existingItem[kSecAttrGeneric as String] as? String ?? ""
//        
//        return Credentials(username: account, password: password, token: token)
//    }
//}
