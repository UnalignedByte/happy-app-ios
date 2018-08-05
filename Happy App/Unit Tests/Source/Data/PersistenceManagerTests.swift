//
//  PersistenceManagerTests.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 30/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import XCTest
import RxTest
import RxBlocking
import RxSwift

class PersistenceManagerTests: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        let keys = UserDefaults.standard.dictionaryRepresentation().keys
        keys.forEach {
            UserDefaults.standard.removeObject(forKey: $0)
        }
    }

    func testSubmissionDateBeforeSaving() throws {
        let persistenceManager = PersistenceManager()
        let observable = persistenceManager.submissionDate.subscribeOn(scheduler)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, .failure)
    }

    func testSubmissionDateAfterSaving() throws {
        let persistenceManager = PersistenceManager()
        let observable = persistenceManager.submissionDate.subscribeOn(scheduler)
        let date = Date()
        persistenceManager.save(submissionDate: date)
        let result = try observable.toBlocking().first()
        XCTAssertEqual(result, .success(date))
    }
}
