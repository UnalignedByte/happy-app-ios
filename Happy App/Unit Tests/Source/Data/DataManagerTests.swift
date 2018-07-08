//
//  DataManagerTests.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 05/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import XCTest
import RxTest
import RxBlocking
import RxSwift

class DataManagerTests: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    // MARK: - Fetcher
    func testNoDataFetcher() {
        let dataManager = DataManager()

        let observable = dataManager.fetchHappinessStatus().subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result<HappinessStatus>.failure)
    }

    func testInvalidDataFetcher() {
        let dataManager = DataManager()
        dataManager.dataFetcher = MockDataFetcherInvalid()

        let observable = dataManager.fetchHappinessStatus().subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result<HappinessStatus>.failure)
    }

    func testValidDataFetcher() {
        let dataManager = DataManager()
        dataManager.dataFetcher = MockDataFetcher()

        let observable = dataManager.fetchHappinessStatus().subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result<HappinessStatus>.success(HappinessStatus()))
    }

    func testDataManagerData() {
        let dataManager = DataManager()
        dataManager.dataFetcher = MockDataFetcher()

        let observable = dataManager.fetchHappinessStatus().subscribeOn(scheduler)
        guard let value = try? observable.toBlocking().first()?.value else {
            XCTFail("Failed to get a value")
            return
        }

        XCTAssertEqual(value?.overallPercentage, 86)
        XCTAssertEqual(value?.submissionsCount, 102)
    }

    // MARK: - Pusher
    func testNoDataPusher() {
        let dataManager = DataManager()

        let observable = dataManager.push(happinessSubmission: HappinessSubmission()).subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result<Void>.failure)
    }

    func testInvalidDataPusher() {
        let dataManager = DataManager()
        dataManager.dataPusher = MockDataPusherInvalid()

        let observable = dataManager.push(happinessSubmission: HappinessSubmission()).subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result<Void>.failure)
    }

    func testValidDataPusher() {
        let dataManager = DataManager()
        dataManager.dataPusher = MockDataPusher()

        let observable = dataManager.push(happinessSubmission: HappinessSubmission()).subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, Result<Void>.success(()))
    }
}
