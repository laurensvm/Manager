//
//  ImageEndPoint.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 05/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public enum ImageApi {
    case getThumbnailImageIds(amount: Int)
    case getThumbnailImage(id: Int)
    case getImage(id: Int)
    case getImageDetails(id: Int)
    
}

extension ImageApi: EndPointType {
    var environmentBaseURL: String {
        return AppConfig.baseURL + "/images/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("Unable to configure base URL") }
        return url
    }
    
    var path: String {
        switch self {
        case .getThumbnailImageIds:
            return "id/"
        case .getThumbnailImage(id: let id):
            return "thumbnail/\(id)/"
        case .getImage(id: let id):
            return "download/\(id)/"
        case .getImageDetails(id: let id):
            return "\(id)/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getThumbnailImageIds(amount: let amount):
            return .requestParameters(bodyParameters: nil, urlParameters: ["amount": amount])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
