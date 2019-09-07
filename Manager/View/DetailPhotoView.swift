//
//  DetailPhotoView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DetailPhotoView: UIView {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        
        // Customize shadows and corner radius
        iv.layer.cornerRadius = 5
//        iv.layer.shadowPath = UIBezierPath(rect: iv.bounds).cgPath
//        iv.layer.shadowRadius = 10
//        iv.layer.shadowOffset = .zero
//        iv.layer.shadowOpacity = 1
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.translatesAutoresizingMaskIntoConstraints = true

        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        self.addSubview(imageView)
        
        // We do this for the animation. Set constraints after the animation is finished
        self.imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
		
    }
    
    func setConstraints() {
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
