//
//  DataPusherTests.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import happyapp

class DataPusherTests: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    func testPushHappinessStatusWithoutUrl() {
        let dataPusher = DataPusher()

        let observable = dataPusher.submissionStatus.subscribeOn(scheduler)
        let result = try? observable.toBlocking().first()

        XCTAssertEqual(result, .failure)
    }
}
