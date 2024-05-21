//
//  UIView+Extension.swift
//  QureAi
//
//  Created by Heeba Khan on 17/05/24.
//

import UIKit

//MARK: This is to add the inspectable attributes for UIView
extension UIView{
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
