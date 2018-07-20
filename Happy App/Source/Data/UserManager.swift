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
    func submit(happinessLevel: Int) -> Observable<Result<None>>
}

class UserManager: UserManagerProtocol {
    var dataManager: DataManagerProtocol?
    private var hasSubmited = Variable(false)

    var canSubmit: Observable<Result<Bool>> {
        guard let _ = dataManager else {
            return Observable.just(.failure)
        }

        return hasSubmited.asObservable().map { .success(!$0) }
    }

    func submit(happinessLevel: Int) -> Observable<Result<None>> {
        hasSubmited.value = true
        return Observable.just(.failure)
    }
}
