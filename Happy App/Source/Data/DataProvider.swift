//
//  DataProvider.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 05/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataProviderProtocol {
    func fetchHappinessStatus() -> Observable<Result<HappinessStatus>>
    func push(happinessSubmission: HappinessSubmission) -> Observable<Result<Void>>
}

class DataProvider {
    var dataFetcher: DataFetcherProtocol?
}

extension DataProvider: DataProviderProtocol {
    func fetchHappinessStatus() -> Observable<Result<HappinessStatus>> {
        guard let dataFetcher = dataFetcher else {
            return Observable.just(.failure)
        }

        return dataFetcher.fetchHappinessJsonData()
        .map { result in
            guard let jsonData = result.value else {
                return .failure
            }
            let decoder = JSONDecoder()
            guard let happinessStatus = try? decoder.decode(HappinessStatus.self, from: jsonData) else {
                return .failure
            }

            return .success(happinessStatus)
        }
    }

    func push(happinessSubmission: HappinessSubmission) -> Observable<Result<Void>> {
        return Observable.just(.failure)
    }
}
