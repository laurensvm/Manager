//
//  NetworkManager.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    private let authenticationRouter = Router<AuthenticationApi>()
    private let filesystemRouter = Router<FileSystemApi>()
    private var token: Token?
    
    override init() {
        super.init()
    }
    
    private func checkTokenBeforeRequest() {
        var credentials: Credentials?
        
        // If there is a token and token
        guard let token = self.token else {
            
            // Make function for this
            do {
                credentials = try UserDefaults.standard.getUserProperties()
                getToken(withCredentials: credentials, completion: { _, _ in return })
            } catch {
                // Find current viewcontroller and present the logincontroller again
                print("To Do")
            }
            return
        }
        
        if Int(token.date.timeIntervalSinceNow) > token.expiration {
            
            // Make function for this
            do {
                credentials = try UserDefaults.standard.getUserProperties()
                getToken(withCredentials: credentials, completion: { _, _ in return })
            } catch {
                // Find current viewcontroller and present the logincontroller again
                print("To Do")
            }
        }
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
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getToken(withCredentials credentials: Credentials?, completion: @escaping (_ token: Token?, _ error: String?) -> ()) {
        guard let username = credentials?.username, let password = credentials?.password else {
            // Find current viewcontroller and present the logincontroller again
            return
            
        }
        getToken(withUsername: username, andPassword: password, completion: completion)
    }
    
    func getToken(withUsername username: String, andPassword password: String, completion: @escaping (_ token: Token?, _ error: String?) -> ()) {
        authenticationRouter.request(.getToken(username: username, password: password), completion: { data, response, error in
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
                        let token = try JSONDecoder().decode(Token.self, from: responseData)
                            
                        // Set keychain updates and userdefaults
                        // TO-DO: Fix with secure way instead of userdefaults !
                        UserDefaults.standard.setLoggedInStatus(value: true)
                        UserDefaults.standard.setUserProperties(credentials: Credentials(username: username, password: password, token: token))
                        
                        // Store token instance in network manager for future calls
                        self.token = token
                        
                        completion(token, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        })
    }
    
    func getDirectoriesInRoot(completion: @escaping (_ directories: [String:[String]]?, _ error: String?) -> ()) {
        
        self.checkTokenBeforeRequest()
        
        if let token = self.token {
            filesystemRouter.request(.getDirectoriesInRoot(token: token), completion: { data, response, error in
                
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
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String: [String]]
                            
                            completion(jsonData, nil)
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
    
    func getDirectories(inDirectory directory: String, completion: @escaping (_ directories: [String:[String]]?, _ error: String?) -> ()) {
        
        if directory == "Documents" {
            getDirectoriesInRoot(completion: completion)
        } else {
            
            self.checkTokenBeforeRequest()
            
            if let token = self.token {
                
                filesystemRouter.request(.getDirectories(directory: directory, token: token), completion: { data, response, error in
                    
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
                                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String: [String]]
                                
                                completion(jsonData, nil)
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
    }
    
}
