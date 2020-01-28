//
//  ProfileViewTransition.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 20/01/2020.
//  Copyright © 2020 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class ProfileViewTransition: NSObject {
    private let duration: TimeInterval = 0.4
    var presenting: Bool = true
}

extension ProfileViewTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: self.presenting ? .to : .from),
            let toView = toViewController.view as? ProfileView
            else {
                return
        }

        // Calculate all constraints
        toView.layoutIfNeeded()
        
        // Calculating constraints is wrong, we use a correctionConstant
        let correctionConstant: CGFloat = 24 + 128 / 2
        
        // Get all the participating views
        let profileImageView = toView.profileImageView
        let filesView = toView.filesView
        let usernameLabel = toView.usernameLabel
        let filesTitleLabel = toView.viewFilesTitleLabel
        let noFilesLabel = toView.noFilesUploaded
        let line = toView.line
        
        // Get the shifting constants
        let horizontalShiftingConstant = transitionContext.containerView.frame.size.width
        let verticalShiftingConstant = transitionContext.containerView.frame.size.height
        
        
        // Copy participating views
    	let profileImageCopy = getProfileImageViewCopy(profileImageView: profileImageView)
        let filesViewCopy = getViewCopy(cv: filesView)
        let usernameCopy = getLabelCopy(clb: usernameLabel)
        let filesTitleLabelCopy = getLabelCopy(clb: filesTitleLabel)
        let noFilesLabelCopy = getLabelCopy(clb: noFilesLabel)
        let lineCopy = getViewCopy(cv: line)
        
        
        // Less code by making arrays
        let originalViews: [UIView] = [filesView, profileImageView, usernameLabel, filesTitleLabel, noFilesLabel, line]
        let copyViews: [UIView] = [filesViewCopy, profileImageCopy, usernameCopy, filesTitleLabelCopy, noFilesLabelCopy, lineCopy]
        
        // Set original views to 0 alpha
        originalViews.forEach({ $0.alpha = 0 })
        
        // Add final view
        transitionContext.containerView.addSubview(toView)
        
        // Add other views
        copyViews.forEach({ transitionContext.containerView.addSubview($0) })
        
        if presenting {
            // Shift final view
            toView.frame.origin.x += horizontalShiftingConstant
            copyViews.forEach({ $0.frame.origin.y += verticalShiftingConstant + correctionConstant })
        }

        UIView.animate(withDuration: self.duration, delay: 0, options: .curveEaseOut, animations: {
                toView.frame.origin.x -= horizontalShiftingConstant
                copyViews.forEach({ $0.frame.origin.y -= verticalShiftingConstant })
		}) { _ in
			
            // Set alpha to 1
            originalViews.forEach({ $0.alpha = self.presenting ? 1 : 0 })
            
            // Remove Copies From View
            copyViews.forEach({ $0.removeFromSuperview() })
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    func getProfileImageViewCopy(profileImageView: UIImageView) -> UIImageView {
        
        let copyProfileImageView: UIImageView = {
            let iv = UIImageView()
            iv.alpha = 1
            iv.frame = profileImageView.frame
            iv.clipsToBounds = profileImageView.clipsToBounds
            iv.contentMode = profileImageView.contentMode
            iv.image = profileImageView.image
            iv.layer.cornerRadius = profileImageView.layer.cornerRadius
            
            iv.layer.masksToBounds = profileImageView.layer.masksToBounds
            
            return iv
        }()
        
        return copyProfileImageView
    }
    
    func getViewCopy(cv: UIView) -> UIView {
        
        let copyV: UIView = {
            let v = UIView()
            v.alpha = 1
            v.frame = cv.frame
            v.backgroundColor = cv.backgroundColor
            v.layer.cornerRadius = cv.layer.cornerRadius
            v.clipsToBounds = cv.clipsToBounds
            
            // Setup shadow
            v.layer.shadowColor = cv.layer.shadowColor
            v.layer.shadowOpacity = cv.layer.shadowOpacity
            v.layer.shadowOffset = cv.layer.shadowOffset
            v.layer.shadowRadius = cv.layer.shadowRadius
            v.layer.masksToBounds = cv.layer.masksToBounds
            
            return v
        }()
        
        return copyV
    }
    
    func getLabelCopy(clb: UILabel) -> UILabel {
        let copyLb: UILabel = {
            let lb = UILabel()
            lb.frame = clb.frame
            lb.font = clb.font
            lb.textColor = clb.textColor
            lb.numberOfLines = clb.numberOfLines
            lb.text = clb.text
            return lb
        }()
        
        return copyLb
    }
    
    
}

