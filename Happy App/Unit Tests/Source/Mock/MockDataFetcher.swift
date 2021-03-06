//
//  MockDataFetcher.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockDataFetcher: DataFetcherProtocol {
    func fetchHappinessStatusJsonData() -> Observable<Result<Data>> {
        guard let fileUrl = Bundle(for: MockDataFetcher.self)
            .url(forResource: "happiness_status", withExtension: "json") else {
            return Observable.just(.failure)
        }

        guard let jsonData = try? Data(contentsOf: fileUrl) else {
            return Observable.just(.failure)
        }

        return Observable.just(.success(jsonData))
    }
}
