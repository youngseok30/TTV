//
//  SplashUseCase.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import RxRelay

protocol SplashUseCase {
    
    var isStarted: BehaviorRelay<Bool> { get set }
    
}
