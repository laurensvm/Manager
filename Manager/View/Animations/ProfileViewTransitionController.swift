//
//  ProfileViewTransitionController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 20/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class ProfileViewTransitionController: NSObject {
    
    private let animator = ProfileViewTransition()
    let seconds: TimeInterval = 4
}

extension ProfileViewTransitionController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}

extension ProfileViewTransitionController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            if let _ = toVC as? ProfileViewController {
                animator.presenting = true
                return animator
            }
            return nil
        default:
//            animator.presenting = false
            return nil
        }
    }
}
