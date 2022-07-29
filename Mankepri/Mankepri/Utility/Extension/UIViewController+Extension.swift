//
//  UIViewController+Extension.swift
//  Mankepri
//
//  Created by Maulana Frasha on 01/07/22.
//

import UIKit
import LocalAuthentication

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
