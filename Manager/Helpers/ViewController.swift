//
//  ViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 29/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class ViewController<V: UIView>: UIViewController {
    
    internal var controllerTitle = ""
    
    override func loadView() {
        view = V()
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var v: V {
        return view as! V
    }
    
}

extension ViewController: BreadCrumbViewController {
    func getViewControllerTitle() -> String {
        return self.controllerTitle
    }
    
    func formatBreadCrumb(withTrail breadCrumbTrail: [String]) -> NSMutableAttributedString {
        // Create '>' as attributed string
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "forward")
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        // Create completed text array
        let completeText = NSMutableAttributedString(string: "")
        
        for (index, section) in breadCrumbTrail.enumerated() {
            if index == breadCrumbTrail.endIndex - 1 && index == 0 {
                return completeText
            } else if index == breadCrumbTrail.endIndex - 1 {
                completeText.append(NSMutableAttributedString(string: "  " + section))
            } else if index == 0 {
                completeText.append(NSMutableAttributedString(string: section + "  "))
                completeText.append(attachmentString)
            } else {
                completeText.append(NSMutableAttributedString(string: "  " + section + "  "))
                completeText.append(attachmentString)
            }
        }
        
        return completeText
    }
    
}
