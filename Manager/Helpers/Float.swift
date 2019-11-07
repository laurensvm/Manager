//
//  Float.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

extension Float {
    func truncate(places : Int)-> Float {
        return Float(floor(pow(10.0, Float(places)) * self) / pow(10.0, Float(places)))
    }
}
