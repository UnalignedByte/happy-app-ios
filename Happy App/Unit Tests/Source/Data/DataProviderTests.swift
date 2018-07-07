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

        XCTAssertEqual(result, Result<HappinessStatus>.failure)
    }

    func testInvalidFetcher() {
        let dataProvider = DataProvider()
        dataProvider.dataFetcher = MockDataFetcherInvalid()

        let observable = dataProvider.happinessStatus.subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result<HappinessStatus>.failure)
    }

    func testValidDataFetcher() {
        let dataProvider = DataProvider()
        dataProvider.dataFetcher = MockDataFetcher()

        let observable = dataProvider.happinessStatus.subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result<HappinessStatus>.success(HappinessStatus()))
    }

    func testDataProviderData() {
        let dataProvider = DataProvider()
        dataProvider.dataFetcher = MockDataFetcher()

        let observable = dataProvider.happinessStatus.subscribeOn(scheduler)
        let value = try? observable.toBlocking().first()?.value

        XCTAssertEqual(value??.overallPercentage, 86)
        XCTAssertEqual(value??.submissionsCount, 102)
    }
}
