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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        customView.delegate = self
    }
    
    convenience init(withMessage message: String?) {
        self.init()
        customView.descriptionLabel.text = message
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.animateAlertView(active: true, completion: nil)
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
