//
//  DataPusher.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataPusherProtocol {
    func push(happinessSubmissionJsonData: Data) -> Observable<Result<Void>>
}

class DataPusher {
    var webApi: WebApiProtocol?
}

extension DataPusher: DataPusherProtocol {
    func push(happinessSubmissionJsonData: Data) -> Observable<Result<Void>> {
        guard let url = webApi?.happinessSubmissionUrl else {
            return Observable.just(.failure)
        }
        return Observable.create { observable in
            URLSession.shared.uploadTask(with: URLRequest(url: url), from: happinessSubmissionJsonData) {
                (data: Data?, response: URLResponse?, error: Error?) in
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                if statusCode == 200 {
                    observable.onNext(.success(()))
                } else {
                    observable.onNext(.failure)
                }
                observable.onCompleted()
            }.resume()
            return Disposables.create()
        }
    }
}
