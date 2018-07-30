//
//  PersistenceManager.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 25/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol PersistenceManagerProtocol {
    var submissionDate: Observable<Result<Date>> { get }
    func save(submissionDate date: Date)
}

class PersistenceManager {
    private let submissionDateVar: Variable<Result<Date>> = Variable(.failure)
}

extension PersistenceManager: PersistenceManagerProtocol {
    var submissionDate: Observable<Result<Date>> {
        return submissionDateVar.asObservable()
    }

    func save(submissionDate date: Date) {
        submissionDateVar.value = .success(date)
    }
}
