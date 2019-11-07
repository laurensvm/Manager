//
//  DirectoryEndPoint.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 04/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public enum DirectoryApi {
    case getDirectories(amount: Int)
    case getDirectory(id: Int)
    case getDirectoryFiles(id: Int, amount: Int)
    case renameDirectory(id: Int, name: String)
    case deleteDirectory(id: Int)
    case deleteDirectory(path: String)
    case getDirectoryUserRights(id: Int)
    case getRootDirectory
    case createDirectory(name: String, parentId: Int)
    case getDirectoryIdFromPath(path: String)
}

extension DirectoryApi: EndPointType {
    var environmentBaseURL: String {
        return AppConfig.baseURL + "/directories/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("Unable to configure base URL") }
        return url
    }
    
    var path: String {
        switch self {
        case .getDirectories:
            return ""
        case .getDirectory(id: let id):
            return "\(id)/"
        case .getDirectoryFiles(id: let id, amount: _):
            return "\(id)/files/"
        case .getRootDirectory:
            return "root/"
        case .createDirectory:
            return "create/"
        default:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .createDirectory:
            return .post
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getDirectories(amount: let amount):
            return .requestParameters(bodyParameters: nil, urlParameters: ["amount": amount])
        case .getDirectoryFiles(id: _, amount: let amount):
            return .requestParameters(bodyParameters: nil, urlParameters: ["amount": amount])
        case .createDirectory(name: let name, parentId: let parentId):
            return .requestParameters(bodyParameters: ["name": name, "parent_id": parentId], urlParameters: nil)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
