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
        
        let leftGesture = UISwipeGestureRecognizer.init()
        leftGesture.direction = .left
        
        let nextButtonEventObservable = self.scheduler.createHotObservable([
            .next(10, ())
        ])
        
        let leftGestureEventObservable = self.scheduler.createHotObservable([
            .next(20, (leftGesture))
        ])
        
        self.input = IntroduceViewModel.Input(
            loginButtonTapEvent: nil,
            nextButtonTapEvent: nextButtonEventObservable.asObservable(),
            viewSwipeEvent: leftGestureEventObservable.asObservable())
        
        self.output = self.viewModel.convert(input: self.input, disposeBag: self.disposeBag)
        
        self.output.introduceData.subscribe(introduceObserver).disposed(by: self.disposeBag)
                
        self.scheduler.start()
        
        XCTAssertEqual(introduceObserver.events, [
            .next(0, IntroduceData.I),
            .next(10, IntroduceData.II),
            .next(20, IntroduceData.III)
        ])
        
        XCTAssertEqual(output.isLastIndex.value, true)
    }
    
    func test_prevIntorduce() {
        let introduceObserver = self.scheduler.createObserver(IntroduceData.self)
        
        let rightGesture = UISwipeGestureRecognizer.init()
        rightGesture.direction = .right
        
        let nextButtonEventObservable = self.scheduler.createHotObservable([
            .next(10, ())
        ])
        
        let rightGestureEventObservable = self.scheduler.createHotObservable([
            .next(20, (rightGesture))
        ])
        
        self.input = IntroduceViewModel.Input(
            loginButtonTapEvent: nil,
            nextButtonTapEvent: nextButtonEventObservable.asObservable(),
            viewSwipeEvent: rightGestureEventObservable.asObservable())
        
        self.output = self.viewModel.convert(input: self.input, disposeBag: self.disposeBag)
        
        self.output.introduceData.subscribe(introduceObserver).disposed(by: self.disposeBag)
                
        self.scheduler.start()
        
        XCTAssertEqual(introduceObserver.events, [
            .next(0, IntroduceData.I),
            .next(10, IntroduceData.II),
            .next(20, IntroduceData.I)
        ])
        
        XCTAssertEqual(output.isLastIndex.value, false)
    }
    
}
