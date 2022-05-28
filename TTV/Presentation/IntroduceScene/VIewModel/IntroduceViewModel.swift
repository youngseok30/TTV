//
//  IntroduceViewModel.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import RxSwift
import RxRelay

final class IntroduceViewModel {
    
    weak var coordinator: IntroduceCoordinator?
    
    init(coordinator: IntroduceCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let loginButtonTapEvent: Observable<Void>
        let nextButtonTapEvent: Observable<Void>
    }
    
    struct Output {
        var introduceData = BehaviorRelay<IntroduceData>(value: .I)
        var isLastIndex = BehaviorRelay<Bool>(value: false)
    }
    
    func convert(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.loginButtonTapEvent
            .subscribe({ [weak self] _ in
                self?.coordinator?.showAuth()
            })
            .disposed(by: disposeBag)
        
        input.nextButtonTapEvent
            .subscribe({ _ in
                output.introduceData.accept(.init(rawValue: output.introduceData.value.rawValue+1) ?? .III)
                output.isLastIndex.accept(output.introduceData.value == .III)
            })
            .disposed(by: disposeBag)
        
        return output
    }
        
}
