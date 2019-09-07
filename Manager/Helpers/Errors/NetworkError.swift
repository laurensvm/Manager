//
//  NetworkError.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "The parameters were nil."
    case encodingFailed = "The parameter encoding has failed."
    case missingURL = "URL is nil."
}
