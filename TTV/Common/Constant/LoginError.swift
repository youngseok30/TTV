//
//  LoginError.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation

enum LoginError: Error {
    case none, invalidEmailPassword, loginFailed, emptyEmail, emptyPassword
    
    var description: String {
        switch self {
        case .none: return ""
        case .invalidEmailPassword:
            return "Invalid E-mail/Password"
        case .loginFailed:
            return "Login Failed"
        case .emptyEmail:
            return "Empty Email"
        case .emptyPassword:
            return "Empty Password"
        }
    }
}
