//
//  UIViewController.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 28.09.2025.
//

import UIKit

extension UIViewController {
    /// Скрывает клавиатуру/пикеры при тапе вне UITextField
    func hideKeyboardWhenTappedAround(action: Selector = #selector(dismissKeyboardBase)) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardBase() {
        view.endEditing(true)
    }
}

