//
//  LoginViewModel.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import RxSwift
import RxRelay

final class LoginViewModel {
    
    private let disposeBag = DisposeBag()
    private let useCase: LoginUseCase
    weak var coordinator: LoginCoordinator?
    
    init(coordinator: LoginCoordinator?, useCase: LoginUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    struct Input {
        let emailTextFieldTapEvent: Observable<Void>
        let passwordTextFieldTapEvent: Observable<Void>
        let logInTapEvent: Observable<Void>
        let signUpTapEvent: Observable<Void>
        let googleLogInTapEvent: Observable<Void>
        let fbLogInTapEvent: Observable<Void>
        let emailText: Observable<String>
        let passwordText: Observable<String>
    }
    
    struct Output {
        var errorString = BehaviorRelay<String>(value: "")
        let emailTextField = BehaviorRelay<String>(value: "")
        let passwordTextField = BehaviorRelay<String>(value: "")
        let emailTextFieldTapEvent = BehaviorRelay<Bool>(value: false)
        let passwordTextFieldTapEvent = BehaviorRelay<Bool>(value: false)
    }
    
    func convert(input: Input, disposeBag: DisposeBag) -> Output {
        setupInput(input: input, disposeBag: disposeBag)
        return setupOutput(input: input, disposeBag: disposeBag)
    }
    
    private func setupInput(input: Input, disposeBag: DisposeBag) {
        input.signUpTapEvent
            .subscribe({ [weak self] _ in
                self?.coordinator?.signUp()
            })
            .disposed(by: disposeBag)
        
        input.googleLogInTapEvent
            .subscribe({ [weak self] _ in
                self?.useCase.googleLogin()
            })
            .disposed(by: disposeBag)
        
        input.fbLogInTapEvent
            .subscribe({ [weak self] _ in
                self?.useCase.fbLogin()
            })
            .disposed(by: disposeBag)
        
        input.emailText
            .bind(to: self.useCase.email)
            .disposed(by: disposeBag)
        
        input.passwordText
            .bind(to: self.useCase.password)
            .disposed(by: disposeBag)
    }
    
    private func setupOutput(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.useCase.loginResult
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let success):
                    if success {
                        self?.useCase.login()
                    } else {
                        output.errorString.accept(LoginError.loginFailed.description)
                    }
                case .failure(let error):
                    output.errorString.accept(error.description)
                }
            })
            .disposed(by: disposeBag)
        
        input.emailTextFieldTapEvent
            .subscribe(onNext: { _ in
                output.emailTextFieldTapEvent.accept(true)
            })
            .disposed(by: disposeBag)
        
        input.passwordTextFieldTapEvent
            .subscribe(onNext: { _ in
                output.passwordTextFieldTapEvent.accept(true)
            })
            .disposed(by: disposeBag)
        
        input.logInTapEvent
            .subscribe(onNext: { [weak self] in
                self?.useCase.login()
            }).disposed(by: disposeBag)
        
        self.useCase.email
            .subscribe(onNext: { email in
                output.emailTextField.accept(email)
            })
            .disposed(by: disposeBag)
        
        self.useCase.password
            .subscribe(onNext: { password in
                output.passwordTextField.accept(password)
            })
            .disposed(by: disposeBag)
        
        return output
    }
        
}
