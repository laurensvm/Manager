//
//  Protocols.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 29/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: class {
    func loginView(_ view: LoginView, didTapLoginButton button: UIButton)
}

protocol CollectionViewDelegate: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionViewHeight() -> CGFloat
}

protocol PhotoViewDelegate: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
}

protocol BreadCrumbViewController {
    func getViewControllerTitle() -> String
}

@objc protocol DetailPhotoDelegate {
    @objc func didTapView(_ sender: UITapGestureRecognizer?)
    @objc func didSwipeUp(_ sender: UISwipeGestureRecognizer?)
    @objc func didSwipeDown(_ sender: UISwipeGestureRecognizer?)
}


// Protocol which will handle the delegation of the keyboard
// methods to the ViewController
protocol KeyboardObserving: class {
    
    func keyboardWillShow(_ notification: Notification)
    func keyboardDidShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
    func keyboardDidHide(_ notification: Notification)
    func keyboardWillChangeFrame(_ notification: Notification)
    func keyboardDidChangeFrame(_ notification: Notification)
    func registerForKeyboardEvents()
    func unregisterFromKeyboardEvents()
}

// Default empty implementation of the Protocol KeyboardControllable
extension KeyboardObserving where Self: UIViewController {
    
    func keyboardWillShow(_ notification: Notification) {}
    func keyboardDidShow(_ notification: Notification) {}
    func keyboardWillHide(_ notification: Notification) {}
    func keyboardDidHide(_ notification: Notification) {}
    func keyboardWillChangeFrame(_ notification: Notification) {}
    func keyboardDidChangeFrame(_ notification: Notification) {}
    
    /// Register for UIKeyboard notifications.
    func registerForKeyboardEvents() {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            self.keyboardWillShow(notification)
        }
        
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil) { notification in
            self.keyboardDidShow(notification)
        }
        
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
            self.keyboardWillHide(notification)
        }
        
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: nil) { notification in
            self.keyboardDidHide(notification)
        }
        
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { notification in
            self.keyboardWillChangeFrame(notification)
        }
        
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidChangeFrameNotification, object: nil, queue: nil) { notification in
            self.keyboardDidChangeFrame(notification)
        }
    }
    
    /// Unregister from UIKeyboard notifications.
    func unregisterFromKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
}



// Protocol which will handle the delegation of the keyboard
// methods to the ViewController
protocol KeyboardControllable: class {
    func handleKeyboardWillShow(_ notification: Notification)
    func handleKeyboardDidShow(_ notification: Notification)
    func handleKeyboardWillHide(_ notification: Notification)
    func handleKeyboardDidHide(_ notification: Notification)
    func handleKeyboardWillChangeFrame(_ notification: Notification)
    func handleKeyboardDidChangeFrame(_ notification: Notification)
}

// Default empty implementation of the Protocol KeyboardControllable
extension KeyboardControllable where Self: UIView {
    func handleKeyboardWillShow(_ notification: Notification) {}
    func handleKeyboardDidShow(_ notification: Notification) {}
    func handleKeyboardWillHide(_ notification: Notification) {}
    func handleKeyboardDidHide(_ notification: Notification) {}
    func handleKeyboardWillChangeFrame(_ notification: Notification) {}
    func handleKeyboardDidChangeFrame(_ notification: Notification) {}
    
}
