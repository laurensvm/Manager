//
//  DetailPhotoViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 07/09/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class DetailPhotoViewController: ViewController<DetailPhotoView> {
    
    private var image: UIImage?
 	
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.imageView.image = image
    }
    
    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
