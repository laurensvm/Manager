//
//  PhotoSettingsCell.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class ImportSettingsCell: SettingsCell {
    
    var delegate: SwitchDelegate?
    
    override func setupViews() {
        super.setupViews()
        self.rightArrow.alpha = 0
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        
    }
}
