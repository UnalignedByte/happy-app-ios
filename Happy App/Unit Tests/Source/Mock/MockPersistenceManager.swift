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
    private let submissionDate = Variable<Result<Date>>(.failure)

    var latestSubmissionDate: Observable<Result<Date>> {
        return submissionDate.asObservable()
    }

    func save(submissionDate date: Date) {
        submissionDate.value = .success(date)
    }
}
