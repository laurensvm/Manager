//
//  FolderCell.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class FolderCell: UICollectionViewCell {
    
    private let folderImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.image = #imageLiteral(resourceName: "folder-content")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var folderName: UILabel = {
        let lb = UILabel()
        lb.textAlignment = NSTextAlignment.center
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenir(size: 12)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(folderImageView)
        self.addSubview(folderName)
        
        self.folderImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.folderImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.folderImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        self.folderImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        self.folderName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.folderName.topAnchor.constraint(equalTo: self.folderImageView.bottomAnchor, constant: 8).isActive = true
//        self.folderName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
