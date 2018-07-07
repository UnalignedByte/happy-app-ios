//
//  DataProvider.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 05/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataProviderProtocol {
    var happinessStatus: Observable<Result<HappinessStatus>> { get }
}

class DataProvider {
    var dataFetcher: DataFetcherProtocol?
}

extension DataProvider: DataProviderProtocol {
    var happinessStatus: Observable<Result<HappinessStatus>> {
        guard let dataFetcher = dataFetcher else {
            return Observable.just(Result<HappinessStatus>.failure)
        }

        return dataFetcher.happinessJsonData
        .map { result in
            guard let _ = result.value else {
                return .failure
            }
            return .success(HappinessStatus())
        }
    }
}
