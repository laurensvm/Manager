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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        customView.didLoadDelegate()
        populateBreadCrumbTrail()
    }
    
    init(withControllerTitle controllerTitle: String = "Documents", andDirectories directories: [String] = []) {
        super.init(nibName: nil, bundle: nil)
        self.controllerTitle = controllerTitle
        self.directories = directories
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
        let documentsViewController = DocumentsViewController(withControllerTitle: directory, andDirectories: ["Wojo", "Nieuwe"])
        self.navigationController?.pushViewController(documentsViewController, animated: true)
    }
    
    
}