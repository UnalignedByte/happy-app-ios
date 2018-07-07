//
//  DataFetcher.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataFetcherProtocol {
    var happinessJsonData: Observable<Result> { get }
}

class DataFetcher {
}

extension DataFetcher: DataFetcherProtocol {
    var happinessJsonData: Observable<Result> {
        return Observable.just(Result.failure)
    }
}
