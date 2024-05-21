//
//  UIFont+Extension.swift
//  QureAi
//
//  Created by Heeba Khan on 21/05/24.
//

import UIKit

extension UIFont {
    enum CustomFont: String {
        case regular = "IBMPlexSans-Regular"
        case bold = "IBMPlexSans-Bold"
        case italic = "IBMPlexSans-Italic"
        case boldItalic = "IBMPlexSans-BoldItalic"
        case extraLight = "IBMPlexSans-ExtraLight"
        case extraLightItalic = "IBMPlexSans-ExtraLightItalic"
        case light = "IBMPlexSans-Light"
        case lightItalic = "IBMPlexSans-LightItalic"
        case medium = "IBMPlexSans-Medium"
        case mediumItalic = "IBMPlexSans-MediumItalic"
        case semiBold = "IBMPlexSans-SemiBold"
        case semiBoldItalic = "IBMPlexSans-SemiBoldItalic"
        case text = "IBMPlexSans-Text"
        case textItalic = "IBMPlexSans-TextItalic"
        case thin = "IBMPlexSans-Thin"
        case thinItalic = "IBMPlexSans-ThinItalic"
        
    }
    
    static func customFont(_ type: CustomFont, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            fatalError("Failed to load the \(type.rawValue) font.")
        }
        return font
    }
}

// Usage examples
// let regularFont = UIFont.customFont(.regular, size: 16)
// let boldFont = UIFont.customFont(.bold, size: 18)

