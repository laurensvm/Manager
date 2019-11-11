//
//  PhotoSettingsViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoSettingsViewController: CollectionViewController<PhotoSettingsView> {
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Photo Settings"
        populateBreadCrumbTrail()
    }
    
    override func collectionViewBehaviour() {
        self.items = [
            [
                SettingsTab(name: "Track Changes", image: #imageLiteral(resourceName: "clock-50"), arrow: false, type: .TrackChanges),
                SettingsTab(name: "Import Photos", image: #imageLiteral(resourceName: "import-export"), arrow: false, type: .Import),
                SettingsTab(name: "Select Import Directory", image: #imageLiteral(resourceName: "folder-50"), arrow: false, type: .ImportDirectory)
            ],
        ]
    }
    
    func populateBreadCrumbTrail() {
        self.navigationController?.viewControllers.forEach({
            if let viewController = $0 as? BreadCrumbViewController {
                self.v.breadCrumbTrail.append(viewController.getViewControllerTitle())
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let tab = items[indexPath.section][indexPath.item] as? SettingsTab else { return UICollectionViewCell() }
        
        switch tab.type {
        case .TrackChanges:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: v.trackChangesCellId, for: indexPath) as! TrackChangesSettingsCell
            cell.delegate = self
            cell._imageView.image = tab.image
            cell._titleLabel.text = tab.name
            cell.rightArrow.alpha = tab.arrow ? 1 : 0
        	return cell
        
        case .Import, .ImportDirectory:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: v.importCellId, for: indexPath) as! ImportSettingsCell
            cell.delegate = self
            cell._imageView.image = tab.image
            cell._titleLabel.text = tab.name
            return cell
            
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.v.headerId, for: indexPath) as! CollectionViewHeader
        header.breadCrumb.attributedText = self.formatBreadCrumb(withTrail: v.breadCrumbTrail)
        header.viewTitleLabel.text = self.controllerTitle
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.v.frame.width - 64, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.v.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tab = items[indexPath.section][indexPath.item] as? SettingsTab else { return }
        switch tab.type {
        case .Import:
            self.v.addSubview(PopUpView(frame: .zero, title: "Importing Photos.."))
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
