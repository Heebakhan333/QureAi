//
//  UIColor+Extension.swift
//  QureAi
//
//  Created by Heeba Khan on 20/05/24.
//

import Foundation
import UIKit

protocol Theme {
    var themeColor: UIColor { get }
    var textColor: UIColor { get }
    // Add more properties as needed
}

protocol ThemeManager {
    var currentTheme: Theme { get set }
    func applyTheme()
}

struct LightTheme: Theme {
    var themeColor: UIColor = UIColor(red: 0, green: 169, blue: 167, alpha: 1.0)
    var textColor: UIColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    // Implement other properties
}

struct DarkTheme: Theme {
    var themeColor: UIColor = UIColor(red: 0, green: 130, blue: 128, alpha: 1.0)
    var textColor: UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    // Implement other properties
}
