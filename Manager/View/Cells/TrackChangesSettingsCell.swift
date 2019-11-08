//
//  PhotoSettingsCell.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class TrackChangesSettingsCell: SettingsCell {
    
    var delegate: SwitchDelegate?
    
    lazy var _switch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(didSwitch(_:)), for: .valueChanged)
        return sw
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(_switch)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        _switch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        _switch.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    @objc func didSwitch(_ sender: UISwitch) {
        delegate?.didTapSwitch(sender)
    }
}
