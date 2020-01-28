//
//  CustomNavigationBar.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.isTranslucent = false
        self.tintColor = Theme.colors.baseBlack
        
        if #available(iOS 13.3, *) {
            let navigationBarAppearence = UINavigationBarAppearance()
            navigationBarAppearence.shadowColor = .clear
            navigationBarAppearence.backgroundColor = .white
            self.backgroundColor = .white
            self.scrollEdgeAppearance = navigationBarAppearence
            self.standardAppearance = navigationBarAppearence
        } else {
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.shadowImage = UIImage()
        }
    }
}
