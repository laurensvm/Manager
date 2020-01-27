//
//  AssetDetailView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 05/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AssetDetailView: View {
    
    private let titleLabel: UILabel = {
        let lb = Label()
        lb.font = Theme.fonts.avenirBlack(size: 30)
        lb.textColor = Theme.colors.baseBlack
        lb.text = "Details"
        return lb
    }()
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.text = "Name: "
        return lb
    }()
    
    lazy var dateLabel: UILabel = {
        let lb = Label()
        lb.setDetailLabel()
        lb.text = "Date: "
        return lb
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = Label()
        lb.setDetailLabel()
        lb.text = "Description: "
        return lb
    }()
    
    lazy var sizeLabel: UILabel = {
        let lb = Label()
        lb.setDetailLabel()
        lb.text = "Size: Unknown"
        return lb
    }()
    
    lazy var map: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 10.0
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(sizeLabel)
        addSubview(descriptionLabel)
        addSubview(map)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
          // Add titleLabel
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // Add namelabel
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // Add Date Label
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // Add size label
            sizeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            sizeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            sizeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // Add Description Label
            descriptionLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // Add map
    //        map.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            map.heightAnchor.constraint(equalToConstant: 250),
            map.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            map.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            map.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
  
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
