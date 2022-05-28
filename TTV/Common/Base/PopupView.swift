//
//  PopupView.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit
import SnapKit

class PopupView: UIView {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.Poppins(.Regular, size: 11)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.init(hex: "#FF5F0AE6")
        self.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setText(_ message: String) {
        self.textLabel.text = message
    }
    
}
