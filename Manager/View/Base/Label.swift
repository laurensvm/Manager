//
//  Label.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 28/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        font = Theme.fonts.avenirBlack(size: 40)
        textColor = Theme.colors.baseBlack
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDetailLabel() {
        font = Theme.fonts.avenir(size: 16)
        textColor = Theme.colors.lightGrey
    }
}

