//
//  MockDataPusherInvalid.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 08/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import happyapp
import RxSwift

class MockDataPusherInvalid {
}

extension MockDataPusherInvalid: DataPusherProtocol {
    func push(happinessSubmissionJsonData: Data) -> Observable<Result<Void>> {
        return Observable.just(.failure)
    }
}
