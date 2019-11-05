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
        
        urlRequest.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
    }
    
    private static func createBody(parameters: Parameters, boundary: String) {
        
        var body = Data()
        
        for (key, value) in parameters {
            
            switch value {
            case let im as UIImage:
                let random = arc4random()
                let file = "image\(random).jpg"
                let data = im.jpegData(compressionQuality: 1);
//                let mimetype = mimeTypeForPath(path: file)
                
                body.add("--\(boundary)\r\n")
                body.add("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(file)\"\r\n")
                body.add("Content-Type: \("MIMETYPE")\r\n\r\n")
                
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
    }
    
//    private static func mimeTypeForPath(path: String) -> String {
//        let pathExtension = path.pathExtension
//        var stringMimeType = "application/octet-stream";
//        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as! CFString, nil)?.takeRetainedValue() {
//            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
//                stringMimeType = mimetype as NSString as String
//            }
//        }
//        return stringMimeType;
//    }
}
