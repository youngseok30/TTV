//
//  SplashViewController.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SplashViewController: BaseViewController {
    
    var disposeBag = DisposeBag()
    var viewModel: SplashViewModel?
    
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ttv_logo"))
        return iv
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "splash_01_background"))
        return iv
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.Poppins(.SemiBold, size: 42)
        label.setLineHeightAndLetterSpacing(lineHeight: 50, letterSpacing: -0.08)
        label.numberOfLines = 0
        label.text = "A.I\nVideo Making\nSoftware"
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start TTV", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = UIFont.Poppins(.SemiBold, size: 15)
        button.titleLabel?.setUnderLine()
        return button
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.Poppins(.Medium, size: 11)
        label.text = "Waynehills Bryant A.I INC"
        return label
    }()
    
    override func setupView() {
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(backgroundView)
        self.view.addSubview(logoImageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(startButton)
        self.view.addSubview(companyLabel)
    }
    
    override func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(131)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(52)
            make.top.equalTo(logoImageView.snp.bottom).offset(28)
        }
        
        startButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(titleLabel.snp.bottom).offset(57)
            make.width.equalTo(68)
            make.height.equalTo(25)
        }
        
        companyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(8)
            make.centerX.equalToSuperview()
        }
    }

    override func bindViewModel() {
        
        let input = SplashViewModel.Input(startButtonTapEvent: self.startButton.rx.tap.asObservable())
        let output = self.viewModel?.convert(input: input, disposeBag: self.disposeBag)
        output?.isStarted
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isStarted in
                if isStarted {
                    
                }
            })
            .disposed(by: self.disposeBag)
        
    }
    
}
