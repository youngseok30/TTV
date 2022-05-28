//
//  CALayer+Extension.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import QuartzCore
import UIKit

extension CALayer {
    
    func addShadow(color: UIColor = .black,
                           alpha: Float = 0.5,
                           x: CGFloat = 0,
                           y: CGFloat = 2,
                           blur: CGFloat = 4,
                           spread: CGFloat = 0,
                           topOnly: Bool = false) {
        
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: topOnly ? -y : y)
        shadowRadius = blur / 2.0
        
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = topOnly ? CGRect(x: 0,y: bounds.maxY - shadowRadius, width: bounds.width, height: shadowRadius) : bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
}
