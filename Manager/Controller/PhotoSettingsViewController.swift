//
//  PhotoSettingsViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoSettingsViewController: ViewController<PhotoSettingsView> {
    
    private let tabs: [[SettingsTab]] = [
        [
            SettingsTab(name: "Track Changes", image: #imageLiteral(resourceName: "clock-50"), arrow: false, type: .TrackChanges),
            SettingsTab(name: "Import Photos", image: #imageLiteral(resourceName: "import-export"), arrow: false, type: .Import),
            SettingsTab(name: "Select Import Directory", image: #imageLiteral(resourceName: "folder-50"), arrow: false, type: .ImportDirectory)
        ],
    ]
    
    private let collectionViewCellHeight: CGFloat = 82
    private let collectionViewSpacing: CGFloat = 12
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Photo Settings"
        customView.delegate = self
        customView.didLoadDelegate()
        
        populateBreadCrumbTrail()
    }
    
    func populateBreadCrumbTrail() {
        self.navigationController?.viewControllers.forEach({
            if let viewController = $0 as? BreadCrumbViewController {
                self.customView.breadCrumbTrail.append(viewController.getViewControllerTitle())
            }
        })
    }
}

extension PhotoSettingsViewController: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    
    }
    
    func collectionViewHeight() -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tab = tabs[indexPath.section][indexPath.item]
        
        switch tab.type {
        case .TrackChanges:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customView.trackChangesCellId, for: indexPath) as! TrackChangesSettingsCell
            cell.delegate = self
            cell._imageView.image = tab.image
            cell._titleLabel.text = tab.name
            cell.rightArrow.alpha = tab.arrow ? 1 : 0
        	return cell
        
        case .Import, .ImportDirectory:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customView.importCellId, for: indexPath) as! ImportSettingsCell
            cell.delegate = self
            cell._imageView.image = tab.image
            cell._titleLabel.text = tab.name
            return cell
            
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.customView.headerId, for: indexPath) as! CollectionViewHeader
        header.breadCrumb.attributedText = self.formatBreadCrumb(withTrail: customView.breadCrumbTrail)
        header.viewTitleLabel.text = self.controllerTitle
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.customView.frame.width - 64, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.customView.frame.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tab = tabs[indexPath.section][indexPath.item]
        switch tab.type {
        case .Import:
            self.customView.addSubview(PopUpView(frame: .zero, title: "Importing Photos.."))
        default:
        break
        }
    }
    
}

extension PhotoSettingsViewController: SwitchDelegate {
    func didTapSwitch(_ sender: UISwitch) {
        print("Did Tap")
        print(sender.isOn)
    }
    
    
}
