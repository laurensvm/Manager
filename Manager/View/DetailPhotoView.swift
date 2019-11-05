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
            DispatchQueue.main.async {
                self.imageView.image = self.image?.imageData
                
                self.detailView.nameLabel.text? = "Name: \(self.image?.name ?? "Unknown")"
            }
        }
    }
    
    var mapPin: MapPin! {
        didSet {
            self.detailView.map.addAnnotation(mapPin)
            
            self.detailView.map.setCenter(mapPin.coordinate, animated: true)
        }
    }
    
    private var imageLayoutConstraints: [NSLayoutConstraint] = []
    private var detailsLayoutConstraints: [NSLayoutConstraint] = []
    
    var detailsViewIsActive: Bool = false
    
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
    
    let detailView: AssetDetailView = {
        let v = AssetDetailView()
        return v
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
        addSubview(imageView)
        addSubview(detailView)
    }
    
    func setConstraints() {
        
        // The value of these constraints depend on the state of the view
        self.imageLayoutConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.detailView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            self.detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 400)
        ]
        NSLayoutConstraint.activate(self.imageLayoutConstraints)
        
        self.detailsLayoutConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -1000),
            self.imageView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.detailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ]
        
        
		// These constraints should always be active
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        detailView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        detailView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSwipeUp() {
        NSLayoutConstraint.deactivate(self.imageLayoutConstraints)
        NSLayoutConstraint.activate(self.detailsLayoutConstraints)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        self.detailsViewIsActive = true
    }
    
    func didSwipeDown() {
        NSLayoutConstraint.deactivate(self.detailsLayoutConstraints)
        NSLayoutConstraint.activate(self.imageLayoutConstraints)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        self.detailsViewIsActive = false
    }
}
