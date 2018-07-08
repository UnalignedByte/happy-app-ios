//
//  DataFetcher.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataFetcherProtocol {
    func fetchHappinessJsonData() -> Observable<Result<Data>>
}

class DataFetcher {
}

extension DataFetcher: DataFetcherProtocol {
    func fetchHappinessJsonData() -> Observable<Result<Data>> {
        return Observable.just(.failure)
    }
}
