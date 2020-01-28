//
//  DemoModePopUpView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 26/12/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DemoModePopUpView: View {
    
    lazy var popOverView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 10.0
        v.layer.masksToBounds = false
        v.layer.shadowColor = Theme.colors.lightGrey.cgColor
        v.layer.shadowOpacity = 0.8
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 5
        v.backgroundColor = .white
        return v
    }()
    
    private let demoLabel: UILabel = {
        let lb = Label()
        lb.font = Theme.fonts.avenirBlack(size: 30)
        lb.textColor = Theme.colors.baseBlack
        lb.text = "Demo Mode"
        return lb
    }()
    
    private let infoLabel: UILabel = {
        let lb = Label()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = .lightGray
        lb.textAlignment = .center
        lb.text = "I noticed that you logged in as a demo user." +
        	" This means that all POST notifications to the server," +
        	" certain functionalities like music and videos and" +
        	" importing from the photo library are disabled."
        	
        return lb
    }()
    
    private let robotImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "robot")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        setupConstraints()
    
    }
    
    private func setupViews() {
        addSubview(popOverView)
        popOverView.addSubview(robotImage)
        popOverView.addSubview(demoLabel)
        popOverView.addSubview(infoLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            popOverView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            popOverView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            popOverView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
            popOverView.topAnchor.constraint(equalTo: robotImage.topAnchor, constant: -8),

            
            robotImage.centerXAnchor.constraint(equalTo: popOverView.centerXAnchor, constant: 0),
            robotImage.bottomAnchor.constraint(equalTo: demoLabel.topAnchor, constant: -8),
            robotImage.widthAnchor.constraint(equalToConstant: 150),
            NSLayoutConstraint.init(item: robotImage, attribute: .height, relatedBy: .equal, toItem: robotImage, attribute: .width, multiplier: 1, constant: 0),
            
            demoLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -8),
            demoLabel.centerXAnchor.constraint(equalTo: popOverView.centerXAnchor, constant: 0),

            infoLabel.bottomAnchor.constraint(equalTo: popOverView.bottomAnchor, constant: -16),
            infoLabel.centerXAnchor.constraint(equalTo: popOverView.centerXAnchor, constant: 0),
            infoLabel.leftAnchor.constraint(equalTo: popOverView.leftAnchor, constant: 16),
            infoLabel.rightAnchor.constraint(equalTo: popOverView.rightAnchor, constant: -16),
        ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
