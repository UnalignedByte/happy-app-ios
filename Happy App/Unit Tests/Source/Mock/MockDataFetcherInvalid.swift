//
//  MockDataFetcherInvalid.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift
@testable import happyapp

class MockDataFetcherInvalid {
}

extension MockDataFetcherInvalid: DataFetcherProtocol {
    var happinessJsonData: Observable<Result> {
        return Observable.just(.failure)
    }
}
