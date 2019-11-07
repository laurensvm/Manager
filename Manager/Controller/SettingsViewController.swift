//
//  SettingsViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 14/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class SettingsViewController: ViewController<SettingsView> {
    
    private let sections: [String] = ["General", ""]
    private let tabs: [[SettingsTab]] = [
    	[
            SettingsTab(name: "User", image: #imageLiteral(resourceName: "user-50-filled"), arrow: true, type: .User),
            SettingsTab(name: "Photos", image: #imageLiteral(resourceName: "photos-50"), arrow: true, type: .Photos),
            SettingsTab(name: "Network", image: #imageLiteral(resourceName: "cloud-50-filled"), arrow: true, type: .Network)
        ],
        [
            SettingsTab(name: "Sign Out", image: #imageLiteral(resourceName: "sign-out-50"), arrow: false, type: .SignOut)
        ]
    ]
    
    var networkManager: NetworkManager!
    
    private let collectionViewCellHeight: CGFloat = 82
    private let collectionViewSpacing: CGFloat = 12
    
    init(withNetworkManager networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.didLoadDelegate()
        
        self.controllerTitle = "Settings"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsViewController: SettingsDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customView.settingsCell, for: indexPath) as! SettingsCell
        
        let tab = tabs[indexPath.section][indexPath.item]
        
        cell.rightArrow.alpha = tab.arrow ? 1 : 0
        cell._imageView.image = tab.image
        cell._titleLabel.text = tab.name
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.customView.headerId, for: indexPath) as! SettingsSectionHeader
        header.title.text = sections[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.customView.frame.width - 64, height: 15)
    }
    
}

extension SettingsViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let settingsTab = tabs[indexPath.section][indexPath.item]
        switch settingsTab.type {
        case .User:
    		break
        case .Photos:
             break
        case .Network:
             break
        case .SignOut:
            self.networkManager.credentialManager.signOut()
            
            if let tabBarController = self.tabBarController {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.presentLoginScreen(rootViewController: tabBarController, animated: true)
            }
        }
    }
}
