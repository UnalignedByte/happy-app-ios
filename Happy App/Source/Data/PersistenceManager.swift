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
    private static let kSubmissionDate = "submission_date"
    private let submissionDateVar: Variable<Result<Date>>
    private let userDefaults: UserDefaults = UserDefaults(suiteName: "group.com.unalignedbyte.happyapp")!

    init() {
        if let date = userDefaults.object(forKey: PersistenceManager.kSubmissionDate) as? Date {
            submissionDateVar = Variable(.success(date))
        } else {
            submissionDateVar = Variable(.failure)
        }
    }
}

extension PersistenceManager: PersistenceManagerProtocol {
    var submissionDate: Observable<Result<Date>> {
        return submissionDateVar.asObservable()
    }

    func save(submissionDate date: Date) {
        userDefaults.set(date, forKey: PersistenceManager.kSubmissionDate)
        submissionDateVar.value = .success(date)
    }
}
