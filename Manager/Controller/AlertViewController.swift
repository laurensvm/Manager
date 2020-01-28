//
//  AlertViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 29/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class AlertViewController: ViewController<AlertView> {
    
    var customTabBarController: UITabBarController?
    
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
        
        handleTapBarController()
        self.v.animateAlertView(active: true, completion: nil)
    }
    
    private func handleTapBarController() {
        guard let tabBar = self.customTabBarController?.tabBar else { return }
        
        toggleTabBar(tabBar: tabBar, hide: tabBar.isHidden ? false : true)
    }
    
    private func toggleTabBar(tabBar: UITabBar, hide: Bool) {
        tabBar.isHidden = hide ? true : false
        UIView.animate(withDuration: 0.1, animations: {
            tabBar.alpha = hide ? 0 : 1
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlertViewController: AlertViewDelegate {
    func dismissViewController() {
        handleTapBarController()
        self.dismiss(animated: false, completion: nil)
    }
}
