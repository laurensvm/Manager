//
//  FileSystemEndPoint.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public enum FileSystemApi {
    case getDirectories(directory: String)
    case getImageList(amount: Int)
    case getImage(url: String)
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
        case .getDirectories:
            return ""
        case .getImageList:
            return "image-list/"
        case .getImage(let url):
            return "image/\(url)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getDirectories:
            return .post
        case .getImageList:
            return .get
        case .getImage:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getDirectories(directory: let directory):
            return .requestParameters(bodyParameters: ["directory": directory], urlParameters: nil)
        case .getImageList(let amount):
            return .requestParameters(bodyParameters: nil, urlParameters: ["amount": amount])
        case .getImage:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

