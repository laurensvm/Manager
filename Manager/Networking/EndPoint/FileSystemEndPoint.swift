//
//  FileSystemEndPoint.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public enum FileSystemApi {
    case getDirectoriesInRoot(token: Token)
}

extension FileSystemApi: EndPointType {
    
    var environmentBaseURL: String {
        return "http://127.0.0.1:5000/filesystem/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("Unable to configure base URL") }
        return url
    }
    
    var path: String {
        switch self {
        case .getDirectoriesInRoot:
            return "root/"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getDirectoriesInRoot(token: let token):
            return .requestHeaders(headers: [
                "Authorization": BasicAuthEncoding.encode(username: token.token, andPassword: ""),
                "Content-Type": "application/json"
                ])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

