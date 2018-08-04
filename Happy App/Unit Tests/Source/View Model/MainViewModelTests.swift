//
//  MainViewModelTests.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 02/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import XCTest
import RxTest
import RxBlocking
import RxSwift

class MainViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    var testScheduler: TestScheduler!
    var viewModel: MainViewModel!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        viewModel = MainViewModel()
    }

    func testTitle() throws {
        let observer = testScheduler.createObserver(String.self)
        viewModel.title.subscribe(observer).disposed(by: disposeBag)
        testScheduler.start()

        let expected = [(next(0, String.forTranslation(.titleBefore)))]
        XCTAssertEqual(observer.events, expected)
    }

    func testResultsHint() throws {
        let observer = testScheduler.createObserver(String.self)
        viewModel.resultsHint.subscribe(observer).disposed(by: disposeBag)
        testScheduler.start()

        let expected = [(next(0, String.forTranslation(.resultsHint)))]
        XCTAssertEqual(observer.events, expected)
    }

    func testSelectionAreaOpacity() throws {
        let observer = testScheduler.createObserver(Double.self)
        viewModel.selectionAreaOpacity.subscribe(observer).disposed(by: disposeBag)
        testScheduler.start()

        let expected = [(next(0, 1.0))]
        XCTAssertEqual(observer.events, expected)
    }

    func testResultsAreaOpacity() throws {
        let observer = testScheduler.createObserver(Double.self)
        viewModel.resultsAreaOpacity.subscribe(observer).disposed(by: disposeBag)
        testScheduler.start()

        let expected = [next(0, 1.0)]
        XCTAssertEqual(observer.events, expected)
    }

    func testResultsOpacity() throws {
        viewModel.userManager = MockUserManager()

        let observer = testScheduler.createObserver(Double.self)
        viewModel.resultsOpacity.subscribe(observer).disposed(by: disposeBag)
        testScheduler.start()

        viewModel.viewDidLoad()
        viewModel.voteButtonPressed(atIndex: 1)

        let expected = [next(0, 0.0), next(0, 1.0)]
        XCTAssertEqual(observer.events, expected)
    }
}
