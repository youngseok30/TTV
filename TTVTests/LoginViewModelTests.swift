//
//  LoginViewModelTests.swift
//  TTVTests
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import XCTest
import RxSwift
import RxTest
@testable import TTV

class LoginViewModelTests: XCTestCase {
    
    private var viewModel: LoginViewModel!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: LoginViewModel.Input!
    private var output: LoginViewModel.Output!
    
    override func setUpWithError() throws {
        self.viewModel = LoginViewModel(
            coordinator: nil, useCase: DefaultLoginUseCase()
        )
        
        self.disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
        self.disposeBag = nil
    }
    
    func test_Login() {
        let loginObserver = self.scheduler.createObserver(String.self)
        let mockEmail = "test@test.com"
        let mockPassword = "1234"
        
        let emailTextObservable = self.scheduler.createHotObservable([
            .next(0, mockEmail)
        ])
        
        let passwordTextObservable = self.scheduler.createHotObservable([
            .next(0, mockPassword)
        ])
        
        let loginObservable = self.scheduler.createHotObservable([
            .next(10, ())
        ])
        
        self.input = LoginViewModel.Input(
            emailTextFieldTapEvent: Observable.just(()),
            passwordTextFieldTapEvent: Observable.just(()),
            logInTapEvent: loginObservable.asObservable(),
            signUpTapEvent: Observable.just(()),
            googleLogInTapEvent: Observable.just(()),
            fbLogInTapEvent: Observable.just(()),
            emailText: emailTextObservable.asObservable(),
            passwordText: passwordTextObservable.asObservable())
        
        self.output = self.viewModel.convert(input: self.input, disposeBag: self.disposeBag)
        
        self.output.errorString.subscribe(loginObserver).disposed(by: self.disposeBag)
        
        self.scheduler.start()
        
        XCTAssertEqual(output.emailTextField.value, mockEmail)
        XCTAssertEqual(output.passwordTextField.value, mockPassword)
        XCTAssertEqual(loginObserver.events, [
            .next(0, ""),
            .next(10, LoginError.invalidEmailPassword.description)
        ])
    }
    
}
