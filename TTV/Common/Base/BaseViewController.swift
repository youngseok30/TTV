//
//  BaseViewController.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit
import SnapKit

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
    
    lazy var popupView: PopupView = {
        let view = PopupView()
        view.makeRoundCorners(cornerRadius: 10)
        return view
    }()
    
    public func showWarningPopup(_ message: String) {
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        
        self.popupView.setText(message)
        
        sceneDelegate.window?.addSubview(self.popupView)
        
        self.popupView.snp.remakeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    public func hideWarningPopup() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.popupView.frame.origin.y = ScreenSize.height
        }) { finished in
            self.popupView.removeFromSuperview()
        }
    }
}
