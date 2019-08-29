//
//  Theme.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 22/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit.UIFont

class Theme {
    class fonts {
        class func avenirLight(size: CGFloat) -> UIFont {
            return UIFont(name: "Avenir-Light", size: size)!
        }
        
        class func avenirBlack(size: CGFloat) -> UIFont {
            return UIFont(name: "Avenir-Black", size: size)!
        }
        
        class func avenirMedium(size: CGFloat) -> UIFont {
            return UIFont(name: "Avenir-Medium", size: size)!
        }
        
        class func avenir(size: CGFloat) -> UIFont {
            return UIFont(name: "Avenir", size: size)!
        }
        
        class func furutaMedium(size: CGFloat) -> UIFont {
            return UIFont(name: "Futura-Medium", size: size)!
        }
        
    }
    
    class inset {
        static let single: Int = 8
        static let double: Int = 16
        static let triple: Int = 32
    }
    
    class colors {
        static let baseBlack: UIColor = UIColor(rgbColorCodeRed: 13, green: 9, blue: 6, alpha: 1)
        static let lightGrey: UIColor = UIColor(rgbColorCodeRed: 182, green: 181, blue: 180, alpha: 1)
        static let superLightGrey: UIColor = UIColor(rgbColorCodeRed: 246, green: 246, blue: 244, alpha: 1)
        static let baseOrange: UIColor = UIColor(rgbColorCodeRed: 253, green: 211, blue: 42, alpha: 1)
        static let lightOrange: UIColor = UIColor(rgbColorCodeRed: 255, green: 217, blue: 146, alpha: 1)
//        static let baseGrey: UIColor = UIColor(rgbColorCodeRed: 61, green: 62, blue: 74, alpha: 1)
//        static let lightBlue: UIColor = UIColor(rgbColorCodeRed: 84, green: 188, blue: 231, alpha: 1)
    }
}
