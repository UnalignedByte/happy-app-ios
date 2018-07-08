//
//  DataFetcherTests.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import XCTest
import RxTest
import RxBlocking
import RxSwift

class DataFetcherTests: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    func testFetchHappinessStatusWithoutUrl() {
        let dataFetcher = DataFetcher()

        let observable = dataFetcher.fetchHappinessJsonData().subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, .failure)
    }
}
