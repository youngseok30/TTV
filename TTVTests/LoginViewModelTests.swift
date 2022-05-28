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
        
        self.input = LoginViewModel.Input(emailTextFieldTapEvent: Observable.just(()), passwordTextFieldTapEvent: Observable.just(()), logInTapEvent: Observable.just(()), signUpTapEvent: Observable.just(()), googleLogInTapEvent: Observable.just(()), fbLogInTapEvent: Observable.just(()))
        
        self.output = self.viewModel.convert(input: self.input, disposeBag: self.disposeBag)
        
        self.output.errorString.subscribe(loginObserver).disposed(by: self.disposeBag)
        
        XCTAssertEqual(loginObserver.events, [
            .next(0, LoginError.invalidEmailPassword.description)
        ])
    }
    
}
