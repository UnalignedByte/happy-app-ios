//
//  UserManager.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 19/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol UserManagerProtocol {
    var canSubmit: Observable<Result<Bool>> { get }

    @discardableResult
    func submit(happinessLevel: Int) -> Observable<Result<None>>
}

class UserManager: UserManagerProtocol {
    var dataManager: DataManagerProtocol?
    var timeManager: TimeManagerProtocol?
    var persistenceManager: PersistenceManagerProtocol?
    let disposeBag = DisposeBag()

    var canSubmit: Observable<Result<Bool>> {
        guard let timeManager = timeManager, let persistenceManager = persistenceManager else {
            return Observable.just(.failure)
        }

        return persistenceManager.latestSubmissionDate
            .map { (dateResult: Result<Date>) -> Observable<Result<Bool>> in
                if let date = dateResult.value {
                    return timeManager.isDayElapsed(since: date)
                } else {
                    return Observable.just(.success(true))
                }
            }.switchLatest()
    }

    @discardableResult
    func submit(happinessLevel: Int) -> Observable<Result<None>> {
        guard let dataManager = dataManager, let persistenceManager = persistenceManager else {
            return Observable.just(.failure)
        }

        let submission = HappinessSubmission()

        let submissionStatus = dataManager.push(happinessSubmission: submission)
        submissionStatus.subscribe { persistenceManager.save(submissionDate: Date()) }.disposed(by: disposeBag)
        return submissionStatus
    }
}
