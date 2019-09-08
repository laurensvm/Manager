//
//  NetworkManager.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    private let router = Router<AuthenticationApi>()
    
    enum NetworkResponse: String {
        case success
        case authenticationError = "Invalid Credentials."
        case badRequest = "Bad Request."
        case outdated = "The URL you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned no data to decode."
        case unableToDecode = "Unable to decode the response"
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
//    func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?, _ error: String?) -> ()) {
//        router.request(.newMovies(page: page), completion: { data, response, error in
//            if error != nil {
//                completion(nil, "Check network connection.")
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue)
//                        return
//                    }
//
//                    do {
//                        let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
//                        completion(apiResponse.movies, nil)
//                    } catch {
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError)
//                }
//            }
//        })
//    }
    
    func login(withUsername username: String, andPassword password: String, completion: @escaping (_ token: Token?, _ error: String?) -> ()) {
        router.request(.getToken(username: username, password: password), completion: { data, response, error in
            if error != nil {
                completion(nil, "Check network connection. Server could be down as well.")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }

                    do {
                        let apiResponse = try JSONDecoder().decode(Token.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        })
    }
}
