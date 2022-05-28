//
//  TTVTextField.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

class TTVTextField: UITextField {

    let placeHolderPadding = UIEdgeInsets(top: 0, left: 10, bottom: 30, right: 0);
    let textPadding = UIEdgeInsets(top: 24, left: 10, bottom: 0, right: 0);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeHolderPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
