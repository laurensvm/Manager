//
//  DirectoryEndPoint.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 04/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public enum DirectoryApi {
    case getDirectories(directory: String, amount: Int)
    case getDirectory(id: Int)
    case getDirectoryFiles(id: Int)
    case renameDirectory(id: Int, name: String)
    case deleteDirectory(id: Int)
    case deleteDirectory(path: String)
    case getDirectoryUserRights(id: Int)
    case getRootDirectory
    case createDirectory(path: String, parentId: Int)
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
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
