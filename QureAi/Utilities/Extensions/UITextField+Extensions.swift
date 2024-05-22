//
//  UITextField+Extensions.swift
//  QureAi
//
//  Created by Heeba Khan on 22/05/24.
//

import UIKit

extension UITextField {
    func applyCustomStyle(borderColor: UIColor? = nil) {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor?.cgColor ?? UIColor.gray.cgColor // Border color
        self.layer.shadowColor = UIColor.black.cgColor // Shadow color
        self.layer.shadowOpacity = 0.5 // Shadow opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        self.layer.shadowRadius = 4 // Shadow radius
        self.clipsToBounds = false // Allow shadow outside bounds
    }
}
