//
//  UILabel+Extension.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import UIKit

extension UILabel {
    
    func setLineHeightAndLetterSpacing(lineHeight: CGFloat, letterSpacing: CGFloat) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttributes([
            .kern: letterSpacing,
            .paragraphStyle: paragraphStyle,
            .baselineOffset: (lineHeight - font.lineHeight) / 4
        ], range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func setUnderLine() {
        guard let labelText = self.text else { return }
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttributes([
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
}
