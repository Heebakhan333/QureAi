//
//  UIButton+Extensions.swift
//  QureAi
//
//  Created by Heeba Khan on 21/05/24.
//

import UIKit

extension UIButton {
    func addShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 4) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}

// Example Usage:
//let button = UIButton(type: .system)
//button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
//button.setTitle("Button", for: .normal)
//button.backgroundColor = .blue
//
//// Add shadow to the button
//button.addShadow()

// Add the button to your view hierarchy
// view.addSubview(button)

