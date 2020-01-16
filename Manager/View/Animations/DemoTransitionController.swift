//
//  DemoTransitionController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 26/12/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DemoTransitionController: NSObject {
    
    private let animator = DemoTransition()
    let seconds: TimeInterval = 4
}

extension DemoTransitionController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.presenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.presenting = false
        return animator
    }
}
