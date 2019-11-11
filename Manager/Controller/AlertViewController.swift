//
//  AlertViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 29/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class AlertViewController: ViewController<AlertView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init() {
        super.init()
        modalPresentationStyle = .overCurrentContext
        v.delegate = self
    }
    
    convenience init(withType type: AlertType, andMessage message: String?) {
        self.init()
        v.messageLabel.text = type.rawValue
        v.descriptionLabel.text = message
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.v.animateAlertView(active: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlertViewController: AlertViewDelegate {
    func dismissViewController() {
        self.dismiss(animated: false, completion: nil)
    }
}
