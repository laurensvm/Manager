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
    
    lazy var messageLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 18)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Error"
        return lb
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenir(size: 14)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Unknown Error"
        return lb
    }()
    
    private lazy var okButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Ok", for: [.normal])
        bt.setTitleColor(Theme.colors.baseOrange, for: [.normal])
        bt.titleLabel?.font = Theme.fonts.avenirBlack(size: 22)
        bt.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        return bt
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
        alertView.addSubview(messageLabel)
        alertView.addSubview(descriptionLabel)
        alertView.addSubview(okButton)
        
        
        // Somehow this constraint breaks the system constraints. Setting priorities fixes it
        let rightConstraint = alertView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        rightConstraint.isActive = true
        rightConstraint.priority = UILayoutPriority(800)
        
        // Alert View
        bottomConstraint = alertView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: calculateConstant(active: false))
        bottomConstraint.isActive = true
        
        
        NSLayoutConstraint.activate([

            
            alertView.heightAnchor.constraint(equalToConstant: height),
            alertView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            // Message Label
            messageLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            messageLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor, constant: 0),
            messageLabel.heightAnchor.constraint(equalToConstant: 16),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 0),
            descriptionLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -8),
            
            // Ok Button
            okButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: 0),
            okButton.heightAnchor.constraint(equalToConstant: 60),
            okButton.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 0),
            okButton.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: 0),
        ])
        
        self.layoutIfNeeded()        
    }
    
    func animateAlertView(active: Bool, completion: ((_: Bool) -> ())? = nil) {
        self.bottomConstraint.constant = calculateConstant(active: active)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.blurView.alpha = active ? 0.4 : 0
            self.layoutIfNeeded()
        }, completion: completion)
    }
}
