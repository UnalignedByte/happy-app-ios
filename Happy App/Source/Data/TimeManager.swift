//
//  TimeManager.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 25/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol TimeManagerProtocol {
    func isDayElapsed(since date: Date) -> Observable<Result<Bool>>
}

class TimeManager {
    private var oneDayInterval: TimeInterval {
        return 1.0
    }
}

extension TimeManager: TimeManagerProtocol {
    func isDayElapsed(since date: Date) -> Observable<Result<Bool>> {
        let oneDayInterval = self.oneDayInterval
        return Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
            .map { _ in .success(date.timeIntervalSinceNow >= oneDayInterval) }
    }
}
