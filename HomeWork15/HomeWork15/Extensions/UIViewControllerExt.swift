//
//  UIViewControllerExt.swift
//  HomeWork15
//
//  Created by  NovA on 23.08.23.
//

import UIKit

class BaseViewController: UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
