//
//  DataManager.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 05/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataManagerProtocol {
    func fetchHappinessStatus() -> Observable<Result<HappinessStatus>>
    func push(happinessSubmission: HappinessSubmission) -> Observable<Result<None>>
    func push(userLogin: UserLogin) -> Observable<Result<None>>
}

class DataManager {
    var dataFetcher: DataFetcherProtocol?
    var dataPusher: DataPusherProtocol?
}

extension DataManager: DataManagerProtocol {
    func fetchHappinessStatus() -> Observable<Result<HappinessStatus>> {
        guard let dataFetcher = dataFetcher else {
            return Observable.just(.failure)
        }

        return dataFetcher.fetchHappinessStatusJsonData()
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

    func push(happinessSubmission: HappinessSubmission) -> Observable<Result<None>> {
        guard let dataPusher = dataPusher else {
            return Observable.just(.failure)
        }

        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(happinessSubmission) else {
            return Observable.just(.failure)
        }

        return dataPusher.push(happinessSubmissionJsonData: jsonData)
        .map { result in
            switch result {
            case .success:
                return .success(None())
            case .failure:
                return .failure
            }
        }
    }

    func push(userLogin: UserLogin) -> Observable<Result<None>> {
        return Observable.just(.success(None()))
    }
}
