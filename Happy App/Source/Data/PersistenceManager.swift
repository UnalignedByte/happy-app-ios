//
//  PersistenceManager.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 25/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol PersistenceManagerProtocol {
    var latestSubmissionDate: Observable<Result<Date>> { get }

    func save(submissionDate date: Date)
}

class PersistenceManager {
    private let submissionDate: Variable<Result<Date>> = Variable(.failure)
}

extension PersistenceManager: PersistenceManagerProtocol {
    var latestSubmissionDate: Observable<Result<Date>> {
        return submissionDate.asObservable()
    }

    func save(submissionDate date: Date) {
        submissionDate.value = .success(date)
    }
}
