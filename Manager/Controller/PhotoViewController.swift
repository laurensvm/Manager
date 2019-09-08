//
//  PhotoViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoViewController: ViewController<PhotoView> {
    
    let imageNames: [String] = ["ana_cheri_bed_3.0", "ana_cheri_waiting", "ana_cheri_bed_2.0", "ana_cheri_in_bed", "ana_cheri_bed_3.0", "ana_cheri_waiting", "ana_cheri_bed_2.0", "ana_cheri_in_bed", "ana_cheri_bed_3.0", "ana_cheri_waiting", "ana_cheri_bed_2.0", "ana_cheri_in_bed", "ana_cheri_bed_3.0", "ana_cheri_waiting", "ana_cheri_bed_2.0", "ana_cheri_in_bed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerTitle = "Photos"
        
        customView.delegate = self
        customView.didLoadDelegate()
        
        populateBreadCrumbTrail()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
    }
}

extension PhotoViewController: CollectionViewDelegate {
    func collectionViewHeight() -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.customView.photoCellId, for: indexPath) as! PhotoCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.customView.frame.width - 4 * 8) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.customView.headerId, for: indexPath) as! CollectionViewHeader
        header.breadCrumb.attributedText = self.formatBreadCrumb(withTrail: customView.breadCrumbTrail)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.customView.frame.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = UIImage(named: self.imageNames[indexPath.item])
        let detailPhotoViewController = DetailPhotoViewController(image: image)
        
        present(detailPhotoViewController, animated: true, completion: nil)
    }
    
}
