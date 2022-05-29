//
//  IntroduceViewController.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class IntroduceViewController: BaseViewController {
    
    var disposeBag = DisposeBag()
    var viewModel: IntroduceViewModel?
    
    private lazy var topImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "#DEDEDE")
        label.font = UIFont.Poppins(.Medium, size: 15)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.Poppins(.Medium, size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "#AAAAAA")
        label.font = UIFont.Poppins(.Regular, size: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = UIFont.Poppins(.Medium, size: 13)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = UIFont.Poppins(.Medium, size: 13)
        return button
    }()
    
    override func setupView() {
        self.view.backgroundColor = .bg_1_1b1b23
        self.view.addSubview(topImageView)
        self.view.addSubview(stepLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(loginButton)
        self.view.addSubview(nextButton)
        self.view.layer.addShadow(color: .black, alpha: 0.25, x: 0, y: 4, blur: 4, spread: 0)
    }
    
    private let margin = 32
    
    override func setupConstraints() {
        
        topImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.frame.width * 350 / 375)
        }
        
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(margin)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(margin)
            make.top.equalTo(stepLabel.snp.bottom).offset(14)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(margin)
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(margin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.width.equalTo(35)
            make.height.equalTo(25)
        }
        
        nextButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(margin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.width.equalTo(35)
            make.height.equalTo(25)
        }
    }

    override func bindViewModel() {
        let input = IntroduceViewModel.Input(
            loginButtonTapEvent: self.loginButton.rx.tap.asObservable(),
            nextButtonTapEvent: self.nextButton.rx.tap.asObservable(),
            viewSwipeEvent:
                self.view.rx
                .swipeGesture(.left, .right)
                .when(.recognized).asObservable())
        
        let output = self.viewModel?.convert(input: input, disposeBag: self.disposeBag)
        bindIntroduceData(output)
    }
    
}

private extension IntroduceViewController {
    func bindIntroduceData(_ output: IntroduceViewModel.Output?) {
        output?.introduceData
            .asDriver()
            .drive(onNext: { [weak self] index in
                self?.topImageView.image = index.image
                self?.stepLabel.text = "TTV A.I Step.\(index.rawValue)"
                self?.titleLabel.text = index.title
                self?.descriptionLabel.text = index.description
                
                self?.titleLabel.setLineHeightAndLetterSpacing(lineHeight: 30, letterSpacing: -0.08)
                self?.descriptionLabel.setLineHeightAndLetterSpacing(lineHeight: 20, letterSpacing: -0.08)
            })
            .disposed(by: self.disposeBag)
        
        output?.isLastIndex
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] result in
                if result {
                    self?.changePositionLoginButton()
                } else {
                    self?.backPositionLoginButton()
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func changePositionLoginButton() {
        nextButton.isHidden = true
        loginButton.snp.remakeConstraints { make in
            make.right.equalToSuperview().inset(margin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.width.equalTo(35)
            make.height.equalTo(25)
        }
    }
    
    func backPositionLoginButton() {
        nextButton.isHidden = false
        loginButton.snp.remakeConstraints { make in
            make.left.equalToSuperview().inset(margin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.width.equalTo(35)
            make.height.equalTo(25)
        }
    }
}
