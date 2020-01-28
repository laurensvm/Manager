//
//  FormDataEncoding.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 04/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit
import AVFoundation

public struct FormDataEncoding: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = createBody(parameters: parameters, boundary: boundary)
        
    }
    
    private static func createBody(parameters: Parameters, boundary: String) -> Data {
        
        var body = Data()
        
        
        for (key, value) in parameters {
            // Key name for image should be 'file'
            // Add the boundary
            body.add("--\(boundary)\r\n")
            
            switch value {
                
            case let imageAsset as PHAssetImageWrapper:
                let mimeType = "image/jpg"
                
                let data = imageAsset.image.jpegData(compressionQuality: 1.0)
            
                body.add("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(imageAsset.name)\"\r\n")
                body.add("Content-Type: \(mimeType)\r\n\r\n")
                
                body.append(data!)
                
                body.add("\r\n")
                
            case let v as AVURLAsset:
                print(v)
            default:
                body.add("--\(boundary)\r\n")
                body.add("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.add("\(value)\r\n")
            }
        }
        
        body.add("--\(boundary)--")
        
        return body
    }
}
