//
//  DocumentsView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DocumentsView: CollectionView {
    
    var containsSubDirectories: Bool = true {
        didSet {
            configureActiveViews()
        }
    }
    var breadCrumbTrail: [String] = []
    
    private lazy var viewTitleLabel: UILabel = {
        let lb = Label()
        lb.text = "Documents"
        return lb
    }()
    
    lazy var breadCrumb: UILabel = {
        let lb = Label()
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = Theme.colors.lightGrey
        return lb
    }()
    
    private lazy var emptyDirectoryImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "no-folder")
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        return iv
    }()
    
    private lazy var emptyDirectory: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenir(size: 16)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Empty Directory"
        return lb
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    override func collectionViewBehaviour() {
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.clipsToBounds = true
        collectionView.isScrollEnabled = true
        collectionView.register(FolderCell.self, forCellWithReuseIdentifier: baseCellId)
    }
    
    override func didLoadDelegate() {
        super.didLoadDelegate()
        
        NSLayoutConstraint.activate([
            // CollectionView
            collectionView.topAnchor.constraint(equalTo: breadCrumb.bottomAnchor, constant: 48),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
        ])
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(viewTitleLabel)
        addSubview(emptyDirectory)
        addSubview(emptyDirectoryImageView)
        addSubview(breadCrumb)
        
 		configureActiveViews()
        
        NSLayoutConstraint.activate([
            // View Title label
            viewTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            viewTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            viewTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
        
            
            // Empty directory
            emptyDirectory.topAnchor.constraint(equalTo: emptyDirectoryImageView.bottomAnchor, constant: 16),
            emptyDirectory.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyDirectory.heightAnchor.constraint(equalToConstant: 50),
            
            // Empty directory image view
            emptyDirectoryImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyDirectoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 25),
            emptyDirectoryImageView.heightAnchor.constraint(equalToConstant: 75),
            emptyDirectoryImageView.widthAnchor.constraint(equalToConstant: 75),
            
            // BreadCrumb
            breadCrumb.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 16),
            breadCrumb.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            breadCrumb.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
        ])
        
    }
    
    private func configureActiveViews() {
        
        emptyDirectoryImageView.isHidden = containsSubDirectories ? true : false
        emptyDirectory.isHidden = containsSubDirectories ? true : false
        collectionView.isHidden = containsSubDirectories ? false : true
        
        collectionView.reloadData()
    }
}
