//
//  SplashViewModelTests.swift
//  TTVTests
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import XCTest
import RxSwift
import RxTest
@testable import TTV

class SplashViewModelTests: XCTestCase {
    
    private var viewModel: SplashViewModel!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: SplashViewModel.Input!
    private var output: SplashViewModel.Output!
    
    override func setUpWithError() throws {
        self.viewModel = SplashViewModel(
            coordinator: nil
        )
        
        self.disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
        self.disposeBag = nil
    }
    
    func test_startTTV() {
        let isStartedObserver = self.scheduler.createObserver(Bool.self)
        let isStartedObservable = self.scheduler.createHotObservable([
            .next(10, ())
        ])
        
        self.input = SplashViewModel.Input(startButtonTapEvent: isStartedObservable.asObservable())
        
        self.output = self.viewModel.convert(input: self.input, disposeBag: self.disposeBag)
        
        self.output.isStarted.subscribe(isStartedObserver).disposed(by: self.disposeBag)
        
        self.scheduler.start()
        
        XCTAssertEqual(isStartedObserver.events, [
            .next(0, false),
            .next(10, true)
        ])
    }
    
}
