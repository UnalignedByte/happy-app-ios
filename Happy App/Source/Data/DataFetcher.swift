//
//  DataFetcher.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataFetcherProtocol {
    func fetchHappinessStatusJsonData() -> Observable<Result<Data>>
}

class DataFetcher {
    var happinessStatusUrl: URL?
}

extension DataFetcher: DataFetcherProtocol {
    func fetchHappinessStatusJsonData() -> Observable<Result<Data>> {
        guard let url = happinessStatusUrl else {
            return Observable.just(.failure)
        }
        return Observable.create { observer in
            URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                if let data = data {
                    observer.onNext(.success(data))
                } else {
                    observer.onNext(.failure)
                }
                observer.onCompleted()
            }.resume()
            return Disposables.create()
        }
    }
}
