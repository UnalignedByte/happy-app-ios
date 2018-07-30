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
}

extension TimeManager: TimeManagerProtocol {
    func isDayElapsed(since date: Date) -> Observable<Result<Bool>> {
        return Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
            .map { _ in
                guard let morningDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) else {
                    return .failure
                }
                let result = date.compare(morningDate)
                return .success(result != .orderedDescending)
        }
    }
}
