//
//  DocumentsView.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DocumentsView: View {
    
    weak var delegate: CollectionViewDelegate!
    
    let folderCellId = "folderCellId"
    var containsSubDirectories: Bool = true {
        didSet {
            configureActiveViews()
        }
    }
    var breadCrumbTrail: [String] = []
    
    private lazy var viewTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Theme.fonts.avenirBlack(size: 40)
        lb.textColor = Theme.colors.baseBlack
        lb.numberOfLines = 0
        lb.text = "Documents"
        return lb
    }()
    
    lazy var breadCrumb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = Theme.colors.lightGrey
        lb.numberOfLines = 0
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
    
    lazy var collectionView: UICollectionView = {
        // CollectionViewFlowLayout
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 16
        cvLayout.minimumInteritemSpacing = 8
        
        // CollectionView
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.backgroundColor = .white
        cv.clipsToBounds = true
        cv.isScrollEnabled = true
        cv.register(FolderCell.self, forCellWithReuseIdentifier: folderCellId)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.backgroundColor = .white
        
        setupViews()
    }
    
    func didLoadDelegate() {
        self.collectionView.dataSource = delegate
        self.collectionView.delegate = delegate
        
        // CollectionView
        self.collectionView.topAnchor.constraint(equalTo: self.breadCrumb.bottomAnchor, constant: 48).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setupViews() {
        self.addSubview(viewTitleLabel)
        self.addSubview(emptyDirectory)
        self.addSubview(emptyDirectoryImageView)
        self.addSubview(collectionView)
        self.addSubview(breadCrumb)
        
 		configureActiveViews()
        
        // View Title label
        self.viewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.viewTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        self.viewTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
    
        
        // Empty directory
        self.emptyDirectory.topAnchor.constraint(equalTo: self.emptyDirectoryImageView.bottomAnchor, constant: 16).isActive = true
        self.emptyDirectory.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.emptyDirectory.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Empty directory image view
        self.emptyDirectoryImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.emptyDirectoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 25).isActive = true
        self.emptyDirectoryImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        self.emptyDirectoryImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        // BreadCrumb
        self.breadCrumb.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor, constant: 16).isActive = true
        self.breadCrumb.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        self.breadCrumb.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32).isActive = true
        self.breadCrumb.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 32)
        
    }
    
    private func configureActiveViews() {
        if containsSubDirectories {
            self.emptyDirectory.isHidden = true
            self.emptyDirectoryImageView.isHidden = true
            
            self.collectionView.isHidden = false
            
        } else {
            self.collectionView.isHidden = true
            
            self.emptyDirectory.isHidden = false
            self.emptyDirectoryImageView.isHidden = false
        }
        
        self.collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
