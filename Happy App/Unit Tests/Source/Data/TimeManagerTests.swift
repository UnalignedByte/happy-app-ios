//
//  TimeManagerTests.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 25/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import XCTest
import RxTest
import RxBlocking
import RxSwift

class TimeManagerTests: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    func testIsDayElapsedSinceNow() throws {
        let timeManager = TimeManager()
        let observable = timeManager.isDayElapsed(since: Date()).subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, .success(false))
    }
}
