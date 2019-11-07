//
//  View.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class View: UIView {
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView(style: .whiteLarge)
        ind.color = Theme.colors.lightGrey
        ind.translatesAutoresizingMaskIntoConstraints = false
        ind.hidesWhenStopped = true
        ind.center = self.center
        return ind
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupIndicatorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIndicatorView() {
        
        // This indicatorView wheel starts spinning on API call
        self.addSubview(self.indicatorView)
        self.bringSubviewToFront(self.indicatorView)
        
        // Indicator View
        self.indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.indicatorView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        self.indicatorView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    func animateIndicatorView() {
        bringSubviewToFront(indicatorView)
        indicatorView.startAnimating()
    }
}
