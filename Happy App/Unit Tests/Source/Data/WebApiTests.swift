//
//  WebApiTests.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 19/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import XCTest

class WebApiTests: XCTest {
    func testHappinessStatusUrl() {
        let webApi = WebApi()
        XCTAssertEqual(webApi.happinessStatusUrl.host, "unalignedbyte.com")
        XCTAssertFalse(webApi.happinessStatusUrl.path.isEmpty)
    }

    func testHappinessSubmissionUrl() {
        let webApi = WebApi()
        XCTAssertEqual(webApi.happinessSubmissionUrl.host, "unalignedbyte.com")
        XCTAssertFalse(webApi.happinessSubmissionUrl.path.isEmpty)
    }
}
