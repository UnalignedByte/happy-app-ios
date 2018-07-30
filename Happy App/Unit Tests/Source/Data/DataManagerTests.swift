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
    func testFetchHappinessStatusWithoutDataFetcher() throws {
        let dataManager = DataManager()
        let observable = dataManager.fetchHappinessStatus().subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, Result<HappinessStatus>.failure)
    }

    func testFetchHappinessStatusWithInvalidDataFetcher() throws {
        let dataManager = DataManager()
        dataManager.dataFetcher = MockDataFetcherInvalid()
        let observable = dataManager.fetchHappinessStatus().subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, Result<HappinessStatus>.failure)
    }

    func testFetchHappinessStatusWithDataFetcher() throws {
        let dataManager = DataManager()
        dataManager.dataFetcher = MockDataFetcher()
        let observable = dataManager.fetchHappinessStatus().subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertNotEqual(result, Result<HappinessStatus>.failure)
    }

    func testFetchHappinessStatusData() throws {
        let dataManager = DataManager()
        dataManager.dataFetcher = MockDataFetcher()
        let observable = dataManager.fetchHappinessStatus().subscribeOn(scheduler)
        guard let value = try observable.toBlocking().first()?.value else {
            XCTFail("Failed to get a value")
            return
        }
        XCTAssertEqual(value.overallPercentage, 86)
        XCTAssertEqual(value.submissionsCount, 102)
    }

    // MARK: - Pusher
    func testPushHappinessSubmissionWithoutDataPusher() throws {
        let dataManager = DataManager()
        let observable = dataManager.push(happinessSubmission: HappinessSubmission(happinessLevel: 1)).subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, Result<None>.failure)
    }

    func testPushHappinessSubmissionWithInvalidDataPusher() throws {
        let dataManager = DataManager()
        dataManager.dataPusher = MockDataPusherInvalid()
        let observable = dataManager.push(happinessSubmission: HappinessSubmission(happinessLevel: 1)).subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, Result<None>.failure)
    }

    func testPushHappinessSubmissionWithDataPusher() throws {
        let dataManager = DataManager()
        dataManager.dataPusher = MockDataPusher()
        let observable = dataManager.push(happinessSubmission: HappinessSubmission(happinessLevel: 1)).subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, Result<None>.success(None()))
    }
}
