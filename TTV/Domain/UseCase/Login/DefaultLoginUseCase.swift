//
//  DefaultLoginUseCase.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import RxSwift
import RxRelay

final class DefaultLoginUseCase: LoginUseCase {
    
    private let disposeBag = DisposeBag()
    
    var loginResult = BehaviorSubject<LoginResult>(value: .failure(.none))
    var email = BehaviorSubject<String>(value: "")
    var password = BehaviorSubject<String>(value: "")
    
    func login() {
        guard let mail = try? self.email.value(),
              let pass = try? self.password.value() else {
            return
        }
        
        guard !mail.isEmpty else {
            return
        }
        
        guard !pass.isEmpty else {
            return
        }
        
        loginResult.onNext(.failure(.invalidEmailPassword))
    }
    
    func googleLogin() {}
    
    func fbLogin() {}
    
}
