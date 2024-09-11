//
//  UIViewController+DismissKeyboard.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/22/1403 AP.
//

import UIKit

extension UIViewController {
    
    func dismissKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardTouchOutside() {
        
        view.endEditing(true)
    }
}
