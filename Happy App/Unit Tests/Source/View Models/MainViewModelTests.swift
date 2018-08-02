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
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    func testTitle() throws {
        let viewModel = MainViewModel()
        let observable = viewModel.title.subscribeOn(scheduler)

        let result = try observable.toBlocking().first()

        let expected = String.forTranslation(.titleBefore)
        XCTAssertEqual(result, expected)
    }

    func testResultsHint() throws {
        let viewModel = MainViewModel()
        let observable = viewModel.resultsHint.subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        let expected = String.forTranslation(.resultsHint)
        XCTAssertEqual(result, expected)
    }

    func testSelectionAreaOpacity() throws {
        let viewModel = MainViewModel()
        let observable = viewModel.selectionAreaOpacity.subscribeOn(scheduler)
        let result = try observable.toBlocking().first() ?? -1.0
        XCTAssertTrue(result § 1.0)
    }

    func testResultsAreaOpacity() throws {
        let viewModel = MainViewModel()
        let observable = viewModel.resultsAreaOpacity.subscribeOn(scheduler)
        let result = try observable.toBlocking().first() ?? -1.0
        XCTAssertTrue(result § 1.0)
    }
}
