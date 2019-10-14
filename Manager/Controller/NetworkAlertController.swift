//
//  NetworkAlertController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class NetworkAlertController: UIAlertController {
    
    init(error: String?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Network Error"
        self.message = error
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.layer.cornerRadius = 10.0
        self.view.clipsToBounds = true
        self.view.backgroundColor = .white
        self.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        print(self.view.subviews)
        self.preferredAction = self.actions[0]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
