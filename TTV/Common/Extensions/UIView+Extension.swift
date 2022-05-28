//
//  UIView+Extension.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

extension UIView {
    
    func addGradient(_ colors: [CGColor], frame: CGRect = .zero, startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0), locaions: [NSNumber]? = nil) {
        self.layer.sublayers?.filter { $0.name == "gradient" }.forEach { $0.removeFromSuperlayer() }
        
        let gradient = CAGradientLayer()
        gradient.frame = frame == .zero ? self.bounds : frame
        gradient.colors = colors
        gradient.name = "gradient"
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = locaions
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func makeRoundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
    
    func makeBorder(color: UIColor?, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color?.cgColor
    }
    
}
