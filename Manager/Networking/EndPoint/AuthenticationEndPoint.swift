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
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

//public enum MovieApi {
//    case recommended(id:Int)
//    case popular(page:Int)
//    case newMovies(page:Int)
//    case video(id:Int)
//}

//extension MovieApi: EndPointType {
//
//    var environmentBaseURL : String {
//        switch NetworkManager.environment {
//        case .production: return "https://api.themoviedb.org/3/movie/"
//        default: return "https://api.themoviedb.org/3/movie/"
//        }
//    }
//
//    var baseURL: URL {
//        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
//        return url
//    }
//
//    var path: String {
//        switch self {
//        case .recommended(let id):
//            return "\(id)/recommendations"
//        case .popular:
//            return "popular"
//        case .newMovies:
//            return "now_playing"
//        case .video(let id):
//            return "\(id)/videos"
//        }
//    }
//
//    var httpMethod: HTTPMethod {
//        return .get
//    }
//
//    var task: HTTPTask {
//        switch self {
//        case .newMovies(let page):
//            return .requestParameters(bodyParameters: nil,
//                                      urlParameters: ["page":page,
//                                                      "api_key":NetworkManager.MovieAPIKey])
//        default:
//            return .request
//        }
//    }
//
//    var headers: HTTPHeaders? {
//        return nil
//    }
//}
