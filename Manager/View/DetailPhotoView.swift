//
//  DetailPhotoView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DetailPhotoView: UIView {
    
    var delegate: DetailPhotoDelegate?
    var image: Image? {
        didSet {
            self.imageView.image = image?.imageData
        }
    }
    
    var tapGestureRecognizer = UITapGestureRecognizer()
    var swipeUpGestureRecognizer = UISwipeGestureRecognizer()
    var swipeDownGestureRecognizer = UISwipeGestureRecognizer()
    
    var bottomConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = true
        
        setupViews()
        setConstraints()
    }
    
    func didLoadDelegate() {
        // Add gesture recognizer
        self.tapGestureRecognizer.addTarget(delegate!, action: #selector(delegate!.didTapView(_:)))
        self.addGestureRecognizer(self.tapGestureRecognizer)
        
        self.swipeUpGestureRecognizer.direction = .up
        self.swipeUpGestureRecognizer.addTarget(delegate!, action: #selector(delegate!.didSwipeUp(_:)))
        self.addGestureRecognizer(swipeUpGestureRecognizer)
        
        self.swipeDownGestureRecognizer.direction = .down
        self.swipeDownGestureRecognizer.addTarget(delegate!, action: #selector(delegate!.didSwipeDown(_:)))
        self.addGestureRecognizer(swipeDownGestureRecognizer)
        
    }
    
    private func setupViews() {
        self.addSubview(imageView)
    }
    
    func setConstraints() {
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        topConstraint = self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        topConstraint.isActive = true
        bottomConstraint = self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        bottomConstraint.isActive = true
//        heightConstraint = self.imageView.heightAnchor.constraint(equalToConstant: 250)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSwipeUp() {
        bottomConstraint.constant = -250
        topConstraint.constant = -250
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func didSwipeDown() {
        bottomConstraint.constant = 0
        topConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    
}
