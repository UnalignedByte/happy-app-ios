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

        let expected = String.forTranslation(String.Translation.titleBefore)
        XCTAssertEqual(result, expected)
    }
}
