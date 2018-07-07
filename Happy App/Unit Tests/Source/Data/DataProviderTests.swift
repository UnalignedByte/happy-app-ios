//
//  DataProviderTests.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 05/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import happyapp

class DataProviderTests: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    func testNoFetcher() {
        let dataProvider = DataProvider()

        let observable = dataProvider.happinessStatus.subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result.failure)
    }

    func testInvalidFetcher() {
        let dataProvider = DataProvider()
        dataProvider.dataFetcher = MockDataFetcherInvalid()

        let observable = dataProvider.happinessStatus.subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result.failure)
    }
}
