//
//  NetworkManager.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkManager: NSObject {
    private let authenticationRouter = Router<AuthenticationApi>()
    private let filesystemRouter = Router<FileSystemApi>()
    private let imageRouter = Router<ImageApi>()
    
    let credentialManager = CredentialManager()
    
    override init() {
        super.init()
        credentialManager.delegate = self
        credentialManager.refreshTokenIfNeeded()
        
        // Give each router (who needs one) a reference to the credentialManager
        authenticationRouter.credentialsManagerDelegate = credentialManager
        filesystemRouter.credentialsManagerDelegate = credentialManager
        imageRouter.credentialsManagerDelegate = credentialManager
    }
    
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
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getToken(completion: @escaping (_ error: String?, _ token: Token?) -> ()) {
        if let credential = credentialManager.getCredentials(),
            let username = credential.user,
        	let password = credential.password {
            authenticationRouter.request(.getToken(username: username, password: password), completion: {
                data, response, error in
                
                if error != nil {
                    print("Error: \(error!)")
                    completion(error!.localizedDescription, nil)
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(NetworkResponse.noData.rawValue, nil)
                            return
                        }
                        
                        do {
                            let token = try JSONDecoder().decode(Token.self, from: responseData)
                            self.credentialManager.updateToken(token: token)
                            completion(nil, token)
                            
                        } catch let error {
                            print("Error: \(error)")
                            completion(error.localizedDescription, nil)
                        }
                    case .failure(let networkFailureError):
                            print("Error: \(networkFailureError)")
                        	completion(networkFailureError, nil)
                    }
                }
                
            })
        }
    }
    
    func getDirectories(inDirectory directory: String, completion: @escaping (_ directories: JSON?, _ error: String?) -> ()) {
        self.filesystemRouter.request(.getDirectories(directory: directory), completion: { data, response, error in
            if error != nil {
                completion(nil, "\(NetworkError.noConnection)")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    let json = try? JSON(data: responseData)
                    completion(json, nil)
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        })
    }
    
    func getImageListIds(amount: Int, completion: @escaping (_ thumbnails: [ThumbnailImage]?, _ error: String?) -> ()) {
        self.imageRouter.request(.getThumbnailImageIds(amount: amount), completion: { data, response, error in
            if error != nil {
                completion(nil, "\(NetworkError.noConnection)")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    let json = try? JSON(data: responseData)
                    
                    let thumbnails = json?["images"].map { ThumbnailImage(id: $0.1.intValue) }
                    
                    completion(thumbnails, nil)
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
                
            }
        })
    }
    
    func getThumbnailImage(id: Int, completion: @escaping (_ data: Data) -> ()) {
        self.imageRouter.request(.getThumbnailImage(id: id), completion: { data, response, error in
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        return
                    }
                    
                    completion(responseData)
                case .failure:
                    return
                }
                
            }
        })
    }
    
    func getImage(id: Int, completion: @escaping (_ data: Data) -> ()) {
        self.imageRouter.request(.getImage(id: id), completion: { data, response, error in
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        return
                    }
                    
                    completion(responseData)
                case .failure:
                    return
                }
                
            }
        })
    }
    
    func getImageDetails(id: Int, completion: @escaping (_ data: JSON?, _ error: String?) -> ()) {
        self.imageRouter.request(.getImageDetails(id: id), completion: { data, response, error in
            if error != nil {
            	completion(nil, "\(NetworkError.noConnection)")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    let json = try? JSON(data: responseData)
                    
                    completion(json, nil)
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
                
            }
        })
    }
    
}
