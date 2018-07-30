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
    var isLoggedIn: Observable<Result<Bool>> { get }
    @discardableResult func submit(happinessLevel: Int) -> Observable<Result<None>>
    func logIn()
}

class UserManager {
    var dataManager: DataManagerProtocol?
    var timeManager: TimeManagerProtocol?
    var persistenceManager: PersistenceManagerProtocol?
    private let disposeBag = DisposeBag()
    private let isLoggedInVar = Variable<Bool>(false)
}

extension UserManager: UserManagerProtocol {
    var canSubmit: Observable<Result<Bool>> {
        guard let timeManager = timeManager, let persistenceManager = persistenceManager else {
            return Observable.just(.failure)
        }

        return Observable.combineLatest(isLoggedIn, persistenceManager.submissionDate) {
            (isLoggedInResult, dateResult) -> Observable<Result<Bool>> in
            guard let isLoggedIn = isLoggedInResult.value else {
                return Observable.just(.failure)
            }

            if isLoggedIn, let date = dateResult.value {
                return timeManager.isDayElapsed(since: date)
            } else {
                return Observable.just(.success(isLoggedIn))
            }
        }.switchLatest()
    }

    var isLoggedIn: Observable<Result<Bool>> {
        return isLoggedInVar.asObservable().map { .success($0) }
    }

    @discardableResult func submit(happinessLevel: Int) -> Observable<Result<None>> {
        guard let dataManager = dataManager, let persistenceManager = persistenceManager else {
            return Observable.just(.failure)
        }

        let submission = HappinessSubmission(happinessLevel: happinessLevel)

        let submissionStatus = dataManager.push(happinessSubmission: submission)
        submissionStatus.subscribe(onNext: { _ in
            persistenceManager.save(submissionDate: Date())
        }).disposed(by: disposeBag)
        return submissionStatus
    }

    func logIn() {
        guard let dataManager = dataManager else { return }

        let userLogin = UserLogin(key: "dummy")

        let loginStatus = dataManager.push(userLogin: userLogin)
        loginStatus.subscribe(onNext: { result in
            self.isLoggedInVar.value = result != Result<None>.failure
        }).disposed(by: disposeBag)
    }
}
