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
import Mockingjay

class DataFetcherTests: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        MockingjayProtocol.addStub(matcher: uri(WebApi().happinessStatusUrl.absoluteString),
                           builder: jsonData(happinessStatusJsonData))
    }

    func testFetchHappinessStatusNoWebApi() {
        let dataFetcher = DataFetcher()

        let observable = dataFetcher.fetchHappinessStatusJsonData().subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, .failure)
    }

    func testFetchHappinessStatusData() {
        let dataFetcher = DataFetcher()
        dataFetcher.webApi = WebApi()

        let observable = dataFetcher.fetchHappinessStatusJsonData().subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()
        guard let count = result??.value?.count else {
            XCTFail("No data has been fetched")
            return
        }

        XCTAssertGreaterThan(count, 0)
    }

    private var happinessStatusJsonData: Data {
        guard let fileUrl = Bundle(for: MockDataFetcher.self)
            .url(forResource: "happiness_status", withExtension: "json") else { fatalError() }
        guard let jsonData = try? Data(contentsOf: fileUrl) else { fatalError() }
        return jsonData
    }
}
