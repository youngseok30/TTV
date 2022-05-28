//
//  BaseViewController.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public func setupView() {}
    public func setupConstraints() {}
    public func bindViewModel() { }
    
    public func configure() {
        setupView()
        setupConstraints()
        bindViewModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
