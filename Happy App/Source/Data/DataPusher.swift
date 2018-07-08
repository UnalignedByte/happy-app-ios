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
}

extension DataPusher: DataPusherProtocol {
    func push(happinessSubmissionJsonData: Data) -> Observable<Result<Void>> {
        return Observable.just(.failure)
    }
}
