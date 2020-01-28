//
//  DemoModePopUpViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 26/12/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DemoModePopUpViewController: ViewController<DemoModePopUpView> {
    
    override init() {
        super.init()
        self.modalPresentationStyle = .popover

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
