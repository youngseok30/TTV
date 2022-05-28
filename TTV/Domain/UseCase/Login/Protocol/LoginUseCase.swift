//
//  LoginUseCase.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import RxSwift

protocol LoginUseCase {
    
    var loginResult: BehaviorSubject<LoginResult> { get set }
    var email: BehaviorSubject<String> { get set }
    var password: BehaviorSubject<String> { get set }
    
    func login()
    func googleLogin()
    func fbLogin()
    
}
