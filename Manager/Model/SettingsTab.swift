//
//  File.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

struct SettingsTab {
    
    public enum Setting {
        case User
        case Photos
        case Network
        case SignOut
        case TrackChanges
        case Import
        case ImportDirectory
        case None
    }
    
    let name: String
    let image: UIImage
    let arrow: Bool
    let type: Setting
}
