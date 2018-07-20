//
//  MockDataManager.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 20/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockDataManager: DataManagerProtocol {
    func fetchHappinessStatus() -> Observable<Result<HappinessStatus>> {
        return Observable.just(.success(HappinessStatus(overallPercentage: 86, submissionsCount: 102)))
    }

    func push(happinessSubmission: HappinessSubmission) -> Observable<Result<None>> {
        return Observable.just(.success(None()))
    }
}
