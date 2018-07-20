//
//  MockDataPusher.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 08/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockDataPusher {
}

extension MockDataPusher: DataPusherProtocol {
    func push(happinessSubmissionJsonData: Data) -> Observable<Result<None>> {
        return Observable.just(.success(None()))
    }
}
