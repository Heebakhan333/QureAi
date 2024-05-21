//
//  ThemeManager.swift
//  QureAi
//
//  Created by Heeba Khan on 20/05/24.
//

import UIKit

class AppThemeManager: ThemeManager {
    var currentTheme: Theme = LightTheme() {
        didSet {
            applyTheme()
        }
    }
    
    func applyTheme() {
        // Apply theme to the app
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.backgroundColor = currentTheme.themeColor
        // Apply theme to other UI elements as needed
    }
}
