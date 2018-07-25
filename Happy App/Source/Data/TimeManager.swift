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
        return Observable.just(.success(false))
    }
}
