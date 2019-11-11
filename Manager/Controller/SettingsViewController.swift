//
//  SettingsViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 14/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class SettingsViewController: CollectionViewController<SettingsView> {
    
    private let networkManager: NetworkManager
    
    private let sections: [String] = ["General", ""]
    
    init(withNetworkManager networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controllerTitle = "Settings"
    }
    
    override func collectionViewBehaviour() {
        self.items = [
            [
                SettingsTab(name: "User", image: #imageLiteral(resourceName: "user-50-filled"), arrow: true, type: .User),
                SettingsTab(name: "Photos", image: #imageLiteral(resourceName: "photos-50"), arrow: true, type: .Photos),
                SettingsTab(name: "Network", image: #imageLiteral(resourceName: "cloud-50-filled"), arrow: true, type: .Network)
            ],
            [
                SettingsTab(name: "Sign Out", image: #imageLiteral(resourceName: "sign-out-50"), arrow: false, type: .SignOut)
            ]
        ]
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.v.frame.width - 64, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.v.sectionHeaderId, for: indexPath) as! SettingsSectionHeader
        header.title.text = sections[indexPath.section]
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.v.frame.width - 64, height: 15)
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let settingsTab = items[indexPath.section][indexPath.item] as? SettingsTab else { return }
        switch settingsTab.type {
        case .User:
    		break
        case .Photos:
            let photosSettingsViewController = PhotoSettingsViewController(withNetworkManager: self.networkManager)
            self.navigationController?.pushViewController(photosSettingsViewController, animated: true)
        case .Network:
             break
        case .SignOut:
            self.networkManager.credentialManager.signOut()
            
            if let tabBarController = self.tabBarController {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.presentLoginScreen(rootViewController: tabBarController, animated: true)
            }
        default:
            break
        }
    }
}
