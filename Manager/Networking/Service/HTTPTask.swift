//
//  HTTPTask.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
        urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionalHeaders: HTTPHeaders?
    )
    case requestHeaders(headers: HTTPHeaders?)
    case requestFormDataParameters(formDataParameters: Parameters?)
    // Add download and upload tasks here later
}
