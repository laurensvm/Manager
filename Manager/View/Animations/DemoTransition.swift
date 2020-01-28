//
//  DemoTransition.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 26/12/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DemoTransition: NSObject {
    private let duration: TimeInterval = 0.75
    var presenting: Bool = true
}

extension DemoTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.presenting {
            animatePresenting(transitionContext)
        } else {
            animateDismiss(transitionContext)
        }
    }
    
    private func animatePresenting(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let fromView = fromViewController.view as? LoginView,
            let toViewController = transitionContext.viewController(forKey: .to),
            let toView = toViewController.view as? DemoModePopUpView
            else {
                return
        }
        
        let finalView = toView.popOverView
        let animationView: UIView = {
            let av = UIView()
            av.frame = fromView.loginButton.frame
            av.backgroundColor = fromView.loginButton.backgroundColor
            av.layer.cornerRadius = fromView.loginButton.layer.cornerRadius
            return av
        }()
        
        toView.popOverView.alpha = 0
        transitionContext.containerView.addSubview(animationView)
        transitionContext.containerView.addSubview(toView)
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: self.duration * 0.4, animations: {
            animationView.backgroundColor = finalView.backgroundColor
        })

        UIView.animate(withDuration: self.duration * 0.5, delay: self.duration * 0.1, options: .curveEaseInOut, animations: {
            animationView.frame = finalView.frame
            animationView.layer.cornerRadius = finalView.layer.cornerRadius
        }, completion: nil)
        
        UIView.animate(withDuration: self.duration * 0.3, delay: self.duration * 0.4, animations: {
            toView.popOverView.alpha = 1
        }, completion: { _ in
            animationView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

	}
    
    private func animateDismiss(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let fromView = fromViewController.view as? DemoModePopUpView
            else {
                return
        }
        
        let popOverView = fromView.popOverView
        
        let animationView: UIView = {
            let av = UIView()
            av.frame = popOverView.frame
            av.alpha = 0
            av.layer.cornerRadius = popOverView.layer.cornerRadius
            av.backgroundColor = popOverView.backgroundColor
            av.layer.masksToBounds = popOverView.layer.masksToBounds
            av.layer.shadowColor = popOverView.layer.shadowColor
            av.layer.shadowOpacity = popOverView.layer.shadowOpacity
            av.layer.shadowOffset = popOverView.layer.shadowOffset
            av.layer.shadowRadius = popOverView.layer.shadowRadius
            return av
        }()
        
        transitionContext.containerView.addSubview(animationView)
        
        UIView.animate(withDuration: self.duration / 4, delay: 0, animations: {
            animationView.alpha = 1
        }, completion: { _ in
            popOverView.removeFromSuperview()
        })
        
        UIView.animate(withDuration: self.duration / 2, delay: self.duration / 4, options: .curveEaseInOut, animations: {
            animationView.frame.origin.y += popOverView.frame.height + 64
        }, completion: { _ in
            animationView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
