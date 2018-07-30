//
//  MockPersistenceManager.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 25/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockPersistenceManager: PersistenceManagerProtocol {
    private let submissionDateVar = Variable<Result<Date>>(.failure)

    var submissionDate: Observable<Result<Date>> {
        return submissionDateVar.asObservable()
    }

    func save(submissionDate date: Date) {
        submissionDateVar.value = .success(date)
    }
}
