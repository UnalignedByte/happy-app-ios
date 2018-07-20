//
//  MockDataPusherInvalid.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 08/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockDataPusherInvalid {
}

extension MockDataPusherInvalid: DataPusherProtocol {
    func push(happinessSubmissionJsonData: Data) -> Observable<Result<None>> {
        return Observable.just(.failure)
    }
}
