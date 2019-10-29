//
//  AlertView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 29/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class AlertView: View {
    
    let height: CGFloat = 150
    var delegate: AlertViewDelegate?
    private var bottomConstraint: NSLayoutConstraint!
    
    private lazy var alertView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 15
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = true
        
        setupViews()
        addGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func calculateConstant(active: Bool) -> CGFloat {
        return active ? CGFloat(-16) : CGFloat(16 * 2 + height)
    }
    
    private func addGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(_: UITapGestureRecognizer) {
        animateAlertView(active: false, completion: {
            _ in
            self.delegate?.dismissViewController()
        })
    }
    
    private func setupViews() {
        addSubview(blurView)
        addSubview(alertView)
        
        bottomConstraint = alertView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: calculateConstant(active: false))
        bottomConstraint.isActive = true
        
        alertView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        alertView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        // Somehow this constraint breaks the system constraints. Setting priorities fixes it
        let rightConstraint = alertView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        rightConstraint.isActive = true
        rightConstraint.priority = UILayoutPriority(800)
        
    }
    
    func animateAlertView(active: Bool, completion: ((_: Bool) -> ())? = nil) {
        self.bottomConstraint.constant = calculateConstant(active: active)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.blurView.alpha = active ? 0.4 : 0
            self.layoutIfNeeded()
        }, completion: completion)
    }
}
