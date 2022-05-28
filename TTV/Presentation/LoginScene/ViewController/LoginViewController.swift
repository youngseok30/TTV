//
//  LoginViewController.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxGesture

final class LoginViewController: BaseViewController {
    
    var disposeBag = DisposeBag()
    var viewModel: LoginViewModel?
    
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ttv_logo"))
        return iv
    }()
    
    private lazy var emailTextField: TTVTextField = {
        let textField = TTVTextField()
        textField.placeholder = "E-mail"
        textField.setPlaceHolderFont(font: .Poppins(.Regular, size: 13))
        textField.setPlaceHolderColor(color: .aaaaaa)
        textField.font = .Poppins(.Regular, size: 15)
        textField.textColor = .white
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .textFieldBackground
        return textField
    }()
    
    private lazy var passwordTextField: TTVTextField = {
        let textField = TTVTextField()
        textField.placeholder = "Password"
        textField.setPlaceHolderFont(font: .Poppins(.Regular, size: 13))
        textField.setPlaceHolderColor(color: .aaaaaa)
        textField.font = .Poppins(.Regular, size: 15)
        textField.textColor = .white
        textField.backgroundColor = .textFieldBackground
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        let buttonColor: UIColor? = .aaaaaa
        
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(buttonColor, for: .normal)
        button.setTitleColor(buttonColor, for: .highlighted)
        button.titleLabel?.font = UIFont.Poppins(.Regular, size: 11)
        return button
    }()
    
    private lazy var errorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .loginWarningColor
        label.textAlignment = .right
        label.font = UIFont.Poppins(.Regular, size: 11)
        label.isHidden = true
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = UIFont.Poppins(.Medium, size: 15)
                
        button.makeRoundCorners(cornerRadius: 24)
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = UIFont.Poppins(.Medium, size: 15)
        button.makeRoundCorners(cornerRadius: 24)
        button.makeBorder(color: UIColor.init(hex: "#6E54F6"), borderWidth: 1)
        button.layer.addBasicShadow()
        
        return button
    }()
    
    private lazy var socialButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 21
        
        stackView.addArrangedSubview(self.googleLoginButton)
        stackView.addArrangedSubview(self.fbLoginButton)
        return stackView
    }()
    
    private lazy var loginDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .Poppins(.Regular, size: 11)
        label.text = "Or log in with social account"
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.Poppins(.Medium, size: 11)
        label.text = "Waynehills Bryant A.I INC"
        return label
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        let image = UIImage.init(named: "i_google_w_38")
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        button.makeRoundCorners(cornerRadius: 24)
        button.layer.addBasicShadow()
        
        return button
    }()
    
    private lazy var fbLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(hex: "#425798")
        let image = UIImage.init(named: "i_facebook_w_38")
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        button.makeRoundCorners(cornerRadius: 24)
        button.layer.addBasicShadow()
        
        return button
    }()
    
    private lazy var hideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lock", for: .normal)
        button.setTitleColor(.aaaaaa, for: .normal)
        button.setTitleColor(.aaaaaa, for: .highlighted)
        button.titleLabel?.font = UIFont.Poppins(.Regular, size: 13)
        return button
    }()
    
    override func setupView() {
        self.view.backgroundColor = .bg_1_1b1b23
        self.view.addSubview(logoImageView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(forgotPasswordButton)
        self.passwordTextField.addSubview(hideButton)
        self.view.addSubview(errorDescriptionLabel)
        self.view.addSubview(loginButton)
        self.view.addSubview(signUpButton)
        self.view.addSubview(loginDescriptionLabel)
        self.view.addSubview(socialButtons)
        self.view.addSubview(companyLabel)
        self.view.layer.addBasicShadow()
    }
    
    override func setupConstraints() {
        let margin = 32
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(36)
            make.left.right.equalToSuperview().inset(margin)
            make.height.equalTo(56)
        }
        
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(margin)
            make.height.equalTo(56)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(6)
            make.left.equalToSuperview().inset(margin)
        }
        
        errorDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(6)
            make.right.equalToSuperview().inset(margin)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(margin)
            make.height.equalTo(48)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(margin)
            make.height.equalTo(48)
        }
        
        loginDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(34)
            make.centerX.equalToSuperview()
        }
        
        socialButtons.snp.makeConstraints { make in
            make.top.equalTo(loginDescriptionLabel.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(margin)
            make.height.equalTo(48)
        }
        
        companyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(8)
            make.centerX.equalToSuperview()
        }
        
        hideButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(11)
        }
    }
    
    override func viewDidLayoutSubviews() {
        loginButton.layer.addBasicShadow()
        loginButton.makeRoundCorners(cornerRadius: 24)
        
        if let color1 = UIColor.init(hex: "#7250FF")?.cgColor, let color2 = UIColor.init(hex: "#A95FF2")?.cgColor {
            loginButton.addGradient([color1, color2], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1,y: 0.5))
        }
        
        signUpButton.layer.addBasicShadow()
        googleLoginButton.layer.addBasicShadow()
        fbLoginButton.layer.addBasicShadow()
    }
    
    override func bindViewModel() {
        let input = LoginViewModel.Input(
            emailTextFieldTapEvent: self.emailTextField.rx.controlEvent(.editingDidBegin).asObservable(),
            passwordTextFieldTapEvent: self.passwordTextField.rx.controlEvent(.editingDidBegin).asObservable(),
            logInTapEvent: self.loginButton.rx.tap.asObservable(),
            signUpTapEvent: self.signUpButton.rx.tap.asObservable(),
            googleLogInTapEvent: self.googleLoginButton.rx.tap.asObservable(),
            fbLogInTapEvent: self.fbLoginButton.rx.tap.asObservable())
        
        let output = viewModel?.convert(input: input, disposeBag: disposeBag)
        output?.errorString
            .asDriver()
            .filter { $0.isEmpty == false }
            .drive(onNext: { [weak self] message in
                self?.errorDescriptionLabel.isHidden = false
                self?.errorDescriptionLabel.text = message
                self?.view.endEditing(true)
                self?.passwordTextField.makeBorder(color: .loginWarningColor, borderWidth: 1)
                self?.emailTextField.makeBorder(color: .loginWarningColor, borderWidth: 1)
                self?.showWarningPopup(message)
            })
            .disposed(by: self.disposeBag)
        
        output?.passwordTextField
            .subscribe({ [weak self] password in
                self?.passwordTextField.makeBorder(color: .textFieldFocus, borderWidth: 1)
                self?.emailTextField.makeBorder(color: nil, borderWidth: 0)
            })
            .disposed(by: self.disposeBag)
        
        output?.emailTextField
            .subscribe({ [weak self] email in
                self?.emailTextField.makeBorder(color: .textFieldFocus, borderWidth: 1)
                self?.passwordTextField.makeBorder(color: nil, borderWidth: 0)
            })
            .disposed(by: self.disposeBag)
        
        bindView()
        bindHideButton()
    }
    
    func bindView() {
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.errorDescriptionLabel.isHidden = true
                self?.view.endEditing(true)
                self?.passwordTextField.makeBorder(color: nil, borderWidth: 0)
                self?.emailTextField.makeBorder(color: nil, borderWidth: 0)
                self?.hideWarningPopup()
            })
            .disposed(by: disposeBag)
    }
    
    func bindHideButton() {
        hideButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let isSecure = (self?.passwordTextField.isSecureTextEntry) ?? false
                
                self?.hideButton.setTitle(isSecure ? "Hide" : "Lock", for: .normal)
                self?.passwordTextField.isSecureTextEntry = !isSecure
            })
            .disposed(by: disposeBag)
    }

}
