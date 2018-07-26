//
//  MockInvalidDataManager.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 20/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockInvalidDataManager: DataManagerProtocol {
    func fetchHappinessStatus() -> Observable<Result<HappinessStatus>> {
        return Observable.just(.failure)
    }

    func push(happinessSubmission: HappinessSubmission) -> Observable<Result<None>> {
        return Observable.just(.failure)
    }

    func push(userLogin: UserLogin) -> Observable<Result<None>> {
        return Observable.just(.failure)
    }
}
