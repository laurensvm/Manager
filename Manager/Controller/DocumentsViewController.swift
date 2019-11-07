//
//  DocumentsViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DocumentsViewController: ViewController<DocumentsView> {
    
    lazy var directories: [String] = []
    
    private var path: String?
    private var networkManager: NetworkManager?
    
    private func getPath() -> String {
        if let path = path {
            return path + "/"
        }
        return ""
    }
    
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
        customView.delegate = self
        customView.didLoadDelegate()
        populateBreadCrumbTrail()
        
        getDirectories()
        
        // Add the add bar button
        self.navigationItem.setRightBarButton(self.addBarButtonItem, animated: true)
    }
    
    private func getDirectories() {
        networkManager?.getDirectories(inDirectory: getPath(), completion: { data, error in
            if let directories = data?["directories"] {
                self.directories = []
                directories.forEach({ _, json in
                    self.directories.append(json["name"].stringValue)
                })
            }
            DispatchQueue.main.async {
                self.customView.containsSubDirectories = !self.directories.isEmpty
                self.customView.collectionView.reloadData()
            }
        })
    }
    
    init(withControllerTitle controllerTitle: String = "Documents", andDirectories directories: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.controllerTitle = controllerTitle
        self.directories = directories
    }
    
    init(withNetworkManager networkManager: NetworkManager?, andControllerTitle controllerTitle: String = "Documents", andPath path: String?) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
        self.controllerTitle = controllerTitle
        self.path = path
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateBreadCrumbTrail() {
        self.navigationController?.viewControllers.forEach({
            if let viewController = $0 as? BreadCrumbViewController {
                self.customView.breadCrumbTrail.append(viewController.getViewControllerTitle())
            }
        })
        self.customView.breadCrumb.attributedText = formatBreadCrumb(withTrail: self.customView.breadCrumbTrail)
    }
}

extension DocumentsViewController: CollectionViewDelegate {
    func collectionViewHeight() -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return directories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.customView.folderCellId, for: indexPath) as! FolderCell
        cell.folderName.text = directories[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.customView.frame.width - (2 * 32 + 2 * 8)) / 3
        let height = width + 20
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let directory = directories[indexPath.item]
        let documentsViewController = DocumentsViewController(withNetworkManager: self.networkManager, andControllerTitle: directory, andPath: getPath() + directory)
        self.navigationController?.pushViewController(documentsViewController, animated: true)
    }
    
    
}

extension DocumentsViewController {
    @objc func addDirectory(_ button: UIButton) {
        let createDirectoryViewController = CreateDirectoryViewController(directory: 1)
        createDirectoryViewController.networkManager = self.networkManager
        createDirectoryViewController.presentationController?.delegate = self
        
        self.present(createDirectoryViewController, animated: true, completion: nil)
    }
}

extension DocumentsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        getDirectories()
    }
}
