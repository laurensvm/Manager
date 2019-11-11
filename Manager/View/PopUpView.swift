//
//  PopUpView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 08/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PopUpView: View {
    
    private var activatedConstraints: [NSLayoutConstraint]?
    private var inactivatedConstraints: [NSLayoutConstraint]?
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 18)
        lb.textColor = Theme.colors.lightGrey
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.alpha = 0
        return lb
    }()
    
    private let completed: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "verified")
        iv.alpha = 0.9
        return iv
    }()
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.titleLabel.text = title
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        // Setup shadow
        layer.cornerRadius = 15
        layer.masksToBounds = false
        layer.shadowColor = Theme.colors.lightGrey.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(titleLabel)
        self.addSubview(completed)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let sv = self.superview else { return }
        
        self.activatedConstraints = [
            bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: -16),
        ]

        self.inactivatedConstraints = [
            topAnchor.constraint(equalTo: sv.bottomAnchor, constant: -200)
        ]
        
        
        NSLayoutConstraint.activate(self.inactivatedConstraints!)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
            leftAnchor.constraint(equalTo: sv.leftAnchor, constant: 16),
            rightAnchor.constraint(equalTo: sv.rightAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            
            completed.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            completed.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            completed.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -8),
            completed.widthAnchor.constraint(equalToConstant: completed.frame.height)
        ])
        
        setNeedsLayout()
        beginAnimation()
    }
    
    private func beginAnimation() {
        NSLayoutConstraint.deactivate(self.inactivatedConstraints!)
        NSLayoutConstraint.activate(self.activatedConstraints!)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.titleLabel.alpha = 1
            })
            
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseInOut, animations: {
                self.titleLabel.alpha = 0
            }) { (_) in
                NSLayoutConstraint.deactivate(self.activatedConstraints!)
                NSLayoutConstraint.activate(self.inactivatedConstraints!)
                
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.layoutIfNeeded()
                }) { (_) in
                    self.removeFromSuperview()
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
