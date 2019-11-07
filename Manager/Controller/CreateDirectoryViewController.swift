//
//  CreateDirectoryViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 06/11/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class CreateDirectoryViewController: ViewController<CreateDirectoryView> {
    
    var networkManager: NetworkManager?
	private var directory: Int!
    
    init(directory: Int) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        self.directory = directory
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.delegate = self
        self.customView.didLoadDelegate()
        self.customView.directory = self.directory
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let pc = self.presentationController {
            if #available(iOS 13.0, *) {
                self.presentationController?.delegate?.presentationControllerDidDismiss?(pc)
            }
        }
        super.dismiss(animated: flag, completion: completion)
    }
}

extension CreateDirectoryViewController: CreateDirectoryDelegate {
    func didTapCreateDirectory(_: UIButton) {
        customView.loading()
        
        let name = customView.directoryName.text ?? ""
        if  name != "" {
            self.networkManager?.createDirectory(withName: name, andParentId: directory, completion: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.customView.accept(completion: {
                            self.dismiss(animated: true, completion: nil)
                        })
                    }
                }
            })
        } else {
            customView.failed(completion: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    func removeSelf(_ sender: UITapGestureRecognizer?) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateDirectoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

extension CreateDirectoryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customView.directoryName.placeholder = ""
    }
}
