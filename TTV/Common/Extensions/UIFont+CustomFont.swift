//
//  UIFont+CustomFont.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

extension UIFont {
    
    public enum Family: String {
        case Light, Regular, Medium, SemiBold, Bold
    }

    static func Poppins(_ family: Family = .Regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Poppins-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
