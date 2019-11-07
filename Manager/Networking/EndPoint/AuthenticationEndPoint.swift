//
//  MovieEndPoint.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation


public enum AuthenticationApi {
    case getToken(username: String, password: String)
    case getUser(username: String)
}

extension AuthenticationApi: EndPointType {
    
    var environmentBaseURL: String {
         return AppConfig.baseURL + "/auth/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("Unable to configure base URL") }
        return url
    }
    
    var path: String {
        switch self {
        case .getToken:
            return "token/"
        case .getUser(username: let username):
            return "users/\(username)/"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getToken(username: let username, password: let password):
            return .requestHeaders(headers: [
                "Authorization": BasicAuthEncoding.encode(username: username, andPassword: password),
                "Content-Type": "application/json"
                ])
        case .getUser:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

