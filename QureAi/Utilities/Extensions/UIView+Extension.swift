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
    
    func addGradientLayer(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    //USAGE:
    //    let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    //    view.backgroundColor = .clear // Set the background color of the view to clear
//        view.addGradientLayer(colors: [UIColor(red: 27/255, green: 37/255, blue: 48/255, alpha: 1.0),
//                                        UIColor(red: 0/255, green: 130/255, blue: 128/255, alpha: 1.0)],
//                              startPoint: CGPoint(x: 0, y: 0),
//                              endPoint: CGPoint(x: 1, y: 1))
}
