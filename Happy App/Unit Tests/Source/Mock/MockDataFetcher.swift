//
//  MockDataFetcher.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift
@testable import happyapp

class MockDataFetcher {
}

extension MockDataFetcher: DataFetcherProtocol {
    var happinessJsonData: Observable<Result<Data>> {
        return Observable.just(.success(Data()))
    }
}
