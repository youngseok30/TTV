//
//  IntroduceViewModelTests.swift
//  TTVTests
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import XCTest
import RxSwift
import RxTest
@testable import TTV

class IntroduceViewModelTests: XCTestCase {
    
    private var viewModel: IntroduceViewModel!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: IntroduceViewModel.Input!
    private var output: IntroduceViewModel.Output!
    
    override func setUpWithError() throws {
        self.viewModel = IntroduceViewModel(
            coordinator: nil
        )
        
        self.disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
        self.disposeBag = nil
    }
    
    func test_nextIntorduce() {
        let introduceObserver = self.scheduler.createObserver(IntroduceData.self)
        
        self.input = IntroduceViewModel.Input(loginButtonTapEvent: Observable.just(()), nextButtonTapEvent: Observable.just(()))
        
        self.output = self.viewModel.convert(input: self.input, disposeBag: self.disposeBag)
        
        self.output.introduceData.subscribe(introduceObserver).disposed(by: self.disposeBag)
        
        XCTAssertEqual(introduceObserver.events, [
            .next(0, IntroduceData.III)
        ])
    }
    
}
