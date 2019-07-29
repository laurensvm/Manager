//
//  ViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 29/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class ViewController<V: UIView>: UIViewController {
    override func loadView() {
        view = V()
    }
    
    var customView: V {
        return view as! V
    }
}
