//
//  MockUserManager.swift
//  Unit Tests
//
//  Created by Rafal Grodzinski on 04/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

@testable import HappyApp
import RxSwift

class MockUserManager: UserManagerProtocol {
    private let hasSubmittedVar = Variable<Bool>(false)
    private let isLoggedInVar = Variable<Bool>(false)

    var canSubmit: Observable<Result<Bool>> {
        return Observable.combineLatest(hasSubmittedVar.asObservable(), isLoggedInVar.asObservable()) { (hasSubmitted, isLoggedIn) -> Observable<Result<Bool>> in
            return Observable.just(.success(!hasSubmitted && isLoggedIn))
        }.switchLatest()
    }

    var isLoggedIn: Observable<Result<Bool>> {
        return isLoggedInVar.asObservable().map { .success($0) }
    }

    @discardableResult func submit(happinessPercentage: Int) -> Observable<Result<None>> {
        if !hasSubmittedVar.value && isLoggedInVar.value {
            return Observable.just(.success(None()))
        }
        return Observable.just(.failure)
    }

    func logIn() {
        isLoggedInVar.value = true
    }
}
