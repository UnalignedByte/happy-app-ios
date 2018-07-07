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
}

extension DataProvider: DataProviderProtocol {
    var happinessStatus: Observable<Result> {
        return Observable.just(Result.failure)
    }
}
