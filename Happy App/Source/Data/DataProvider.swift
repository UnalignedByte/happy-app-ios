//
//  DataProvider.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 05/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataProviderProtocol {
    var happinessStatus: Observable<Result> { get }
}

class DataProvider {
    var dataFetcher: DataFetcherProtocol?
}

extension DataProvider: DataProviderProtocol {
    var happinessStatus: Observable<Result> {
        return dataFetcher?.happinessJsonData ?? Observable.just(Result.failure)
    }
}
