//
//  DocumentsViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DocumentsViewController: CollectionViewController<DocumentsView> {
    
    var _children: [Base] = [] {
        didSet {
            DispatchQueue.main.async {
                self.v.containsSubDirectories = !self._children.isEmpty
                self.v.collectionView.reloadData()
            }
        }
    }
    
    var directory: Directory? {
        didSet {
            guard let directory = directory else { return }
            self.getChildrenFromDirectory(withId: directory.id) { (children) in
                self._children = children
            }
        }
    }
    private var networkManager: NetworkManager?

    private lazy var addBarButtonItem: UIBarButtonItem = {
        let addButton = UIButton(type: .custom)
        addButton.setImage(#imageLiteral(resourceName: "plug-50"), for: .normal)
        
        addButton.addTarget(self, action: #selector(addDirectory(_:)), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: addButton)
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 32).isActive = true
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getDirectories()
        
        if directory == nil {
            getDirectoryFromId(id: 1)
        }
        
        populateBreadCrumbTrail()
        
        // Add the add bar button
        self.navigationItem.setRightBarButton(self.addBarButtonItem, animated: true)
    }
    
    init(withNetworkManager networkManager: NetworkManager?, andControllerTitle controllerTitle: String = "Documents", andDirectory directory: Directory? = nil) {
        super.init()
        self.networkManager = networkManager
        self.controllerTitle = controllerTitle
        self.directory = directory
    }
    
    private func getDirectoryFromId(id: Int) {
        self.networkManager?.getDirectoryById(id: id, completion: { directory, error in
            if let directory = directory {
                self.directory = directory
            }
        })
    }
    
    private func getChildrenFromDirectory(withId id: Int, completion: @escaping (_ children: [Base]) -> ()) {
        self.networkManager?.getChildren(inDirectory: id, completion: { children, error in
            guard let children = children else { return }
            completion(children)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateBreadCrumbTrail() {
        self.navigationController?.viewControllers.forEach({
            if let viewController = $0 as? BreadCrumbViewController {
                self.v.breadCrumbTrail.append(viewController.getViewControllerTitle())
            }
        })
        self.v.breadCrumb.attributedText = formatBreadCrumb(withTrail: self.v.breadCrumbTrail)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _children.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.v.baseCellId, for: indexPath) as! FolderCell
        let child = _children[indexPath.item]
        
        // Switch statement was more obscure
        if let child = child as? File {
            cell.folderName.text = child.name
            switch child.type {
            case .image:
                cell.folderImageView.image = #imageLiteral(resourceName: "image")
            case .pdf:
                cell.folderImageView.image = #imageLiteral(resourceName: "pdf")
            case .video:
                cell.folderImageView.image = #imageLiteral(resourceName: "video")
            case .txt:
                cell.folderImageView.image = #imageLiteral(resourceName: "txt")
            default:
                cell.folderImageView.image = #imageLiteral(resourceName: "file")
            }
            
        } else if let child = child as? Directory {
            cell.folderName.text = child.name
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.v.frame.width - (2 * 32 + 2 * 8)) / 3
        let height = width + 20
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let child = _children[indexPath.item]
        
        if let child = child as? Directory {
            let documentsViewController = DocumentsViewController(withNetworkManager: self.networkManager, andControllerTitle: child.name)
            documentsViewController.directory = child
            self.navigationController?.pushViewController(documentsViewController, animated: true)
        }
    }
    
    
}

extension DocumentsViewController {
    @objc func addDirectory(_ button: UIButton) {
        guard let directory = self.directory else { return }
        let createDirectoryViewController = CreateDirectoryViewController(directory: directory)
        createDirectoryViewController.networkManager = self.networkManager
        createDirectoryViewController.presentationController?.delegate = self
        
        self.present(createDirectoryViewController, animated: true, completion: nil)
    }
}

extension DocumentsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        guard let directory = self.directory else { return }
        getChildrenFromDirectory(withId: directory.id) { (children) in
            self._children = children
        }
    }
}
