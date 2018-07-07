//
//  DataPusher.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 07/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol DataPusherProtocol {
    var submissionStatus: Observable<Result<String>> { get }

    func push(happinessSubmissionJsonData: Data)
}

class DataPusher {
}

extension DataPusher: DataPusherProtocol {
    var submissionStatus: Observable<Result<String>> {
        return Observable.just(.failure)
    }

    func push(happinessSubmissionJsonData: Data) {
    }
}
