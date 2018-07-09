//
//  MockDataFetcherInvalid.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockDataFetcherInvalid {
}

extension MockDataFetcherInvalid: DataFetcherProtocol {
    func fetchHappinessStatusJsonData() -> Observable<Result<Data>> {
        return Observable.just(.failure)
    }
}
