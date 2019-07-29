//
//  UIColor.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 22/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        
        let r: CGFloat = CGFloat(red) / 255
        let g: CGFloat = CGFloat(green) / 255
        let b: CGFloat = CGFloat(blue) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
        
    }
}
