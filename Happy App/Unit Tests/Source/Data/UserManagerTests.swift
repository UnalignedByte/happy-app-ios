//
//  UserManagerTests.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 19/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import XCTest
import RxTest
import RxBlocking
import RxSwift

class UserManagerTests: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    func testCanSubmitWithoutDataManager() throws {
        let userManager = UserManager()
        let observable = userManager.canSubmit.subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, Result<Bool>.failure)
    }

    func testCanSubmitWithDataManager() throws {
        let userManager = UserManager()
        userManager.dataManager = MockDataManager()
        let observable = userManager.canSubmit.subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, .success(true))
        _ = userManager.submit(happinessLevel: 1)
        let result2 = try observable.toBlocking().first()
        XCTAssertEqual(result2, .success(false))
    }
}
