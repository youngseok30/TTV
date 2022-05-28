//
//  UITextField+Extension.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

extension UITextField {
    
    func setPlaceHolderFont(font: UIFont?) {
        guard let font = font, let placeholder = placeholder else { return }
        
        let attributedString:NSMutableAttributedString
        if let placeHolderAttributedText = self.attributedPlaceholder {
            attributedString = NSMutableAttributedString(attributedString: placeHolderAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: placeholder)
        }
        
        attributedString.addAttributes([
            .font: font
        ], range: NSMakeRange(0, attributedString.length))
        
        self.attributedPlaceholder = attributedString
    }

    func setPlaceHolderColor(color: UIColor?) {
        guard let color = color, let placeholder = placeholder else { return }
        
        let attributedString:NSMutableAttributedString
        if let placeHolderAttributedText = self.attributedPlaceholder {
            attributedString = NSMutableAttributedString(attributedString: placeHolderAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: placeholder)
        }
        
        attributedString.addAttributes([
            .foregroundColor: color
        ], range: NSMakeRange(0, attributedString.length))
        
        self.attributedPlaceholder = attributedString
    }
    
}
