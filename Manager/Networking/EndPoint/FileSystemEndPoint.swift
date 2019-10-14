//
//  FileSystemEndPoint.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public enum FileSystemApi {
    case getDirectoriesInRoot
    case getDirectories(directory: String)
    case postImage(image: Data)
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
            return ""
        case .getDirectories:
            return ""
        case .postImage:
            return "images/post/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getDirectoriesInRoot:
            return .get
        case .getDirectories:
            return .post
        case .postImage:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getDirectoriesInRoot:
            return .request
//            return .requestHeaders(headers: [
//                "Authorization": BasicAuthEncoding.encode(username: tokenString, andPassword: ""),
//                "Content-Type": "application/json"
//                ])
        case .getDirectories(directory: let directory):
            return .requestParameters(bodyParameters: ["directory": directory], urlParameters: nil)
        case .postImage(image: let image):
            return .requestParameters(bodyParameters: nil, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

