//
//  SplashViewModel.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import RxSwift
import RxRelay

final class SplashViewModel {
    
    weak var coordinator: SplashCoordinator?
    
    init(coordinator: SplashCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let startButtonTapEvent: Observable<Void>
    }
    
    struct Output {
        var isStarted = BehaviorRelay<Bool>(value: false)
    }
    
    func convert(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.startButtonTapEvent
            .subscribe({ _ in
                output.isStarted.accept(true)
            })
            .disposed(by: disposeBag)
        
        output.isStarted
            .filter { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.showIntroduce()
            })
            .disposed(by: disposeBag)
        
        return output
    }
        
}
