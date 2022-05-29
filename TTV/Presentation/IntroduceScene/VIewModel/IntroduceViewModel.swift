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
        let loginButtonTapEvent: Observable<Void>?
        let nextButtonTapEvent: Observable<Void>?
        let viewSwipeEvent: Observable<UISwipeGestureRecognizer>?
    }
    
    struct Output {
        var introduceData = BehaviorRelay<IntroduceData>(value: .I)
        var isLastIndex = BehaviorRelay<Bool>(value: false)
    }
    
    func convert(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.loginButtonTapEvent?
            .subscribe({ [weak self] _ in
                self?.coordinator?.showAuth()
            })
            .disposed(by: disposeBag)
        
        input.nextButtonTapEvent?
            .subscribe({ [weak self] _ in
                self?.bindIntroduceData(output: output)
            })
            .disposed(by: disposeBag)
        
        input.viewSwipeEvent?
            .subscribe({ [weak self] result in
                self?.bindIntroduceData(output: output, result.element?.direction)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func bindIntroduceData(output: IntroduceViewModel.Output, _ direction: UISwipeGestureRecognizer.Direction? = .left) {
        let index = direction == .left ? output.introduceData.value.rawValue + 1 : output.introduceData.value.rawValue - 1
        output.introduceData.accept(.init(rawValue: index) ?? .III)
        output.isLastIndex.accept(output.introduceData.value == .III)
    }
        
}
