//
//  DetailViewTransition.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DetailViewTransition: NSObject {
    
    var transitionMode: DetailViewTransitionMode = .present
    let duration = 10.0
    var originFrame = CGRect.zero
    
    
    enum DetailViewTransitionMode: Int {
        case present
        case dismiss
    }
    
}


extension DetailViewTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.clipsToBounds = true
        containerView.addSubview(toView)
        print(toView.frame)
        toView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        print(toView.frame)
        toView.center = CGPoint(x: toView.frame.minX / 2, y: toView.frame.minY / 2)
        UIView.animate(
            withDuration: duration,
            animations: {
                toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        },
            completion: { _ in
                transitionContext.completeTransition(true)
        }
        )
        
        
    }
}
