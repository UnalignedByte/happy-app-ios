//
//  MockTimeManager.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 25/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockTimeManager: TimeManagerProtocol {
    func isDayElapsed(since date: Date) -> Observable<Result<Bool>> {
        return Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
            .map { _ in .success(date.timeIntervalSinceNow > 2.0) }
    }
}
