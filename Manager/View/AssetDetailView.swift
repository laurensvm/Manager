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
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 30)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Details"
        return lb
    }()
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenir(size: 16)
        lb.textColor = Theme.colors.lightGrey
        lb.numberOfLines = 0
        lb.text = "Name: "
        return lb
    }()
    
    lazy var dateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenir(size: 16)
        lb.textColor = Theme.colors.lightGrey
        lb.numberOfLines = 0
        lb.text = "Date: "
        return lb
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenir(size: 16)
        lb.textColor = Theme.colors.lightGrey
        lb.numberOfLines = 0
        lb.text = "Description: "
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
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
        addSubview(map)
    }
    
    private func setupConstraints() {
        // Add titleLabel
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        // Add namelabel
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        // Add Date Label
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        // Add Description Label
        descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        // Add map
//        map.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32).isActive = true
        map.heightAnchor.constraint(equalToConstant: 250).isActive = true
        map.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        map.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        map.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
