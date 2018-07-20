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
}

class UserManager: UserManagerProtocol {
    var dataManager: DataManagerProtocol?

    var canSubmit: Observable<Result<Bool>> {
        return Observable.just(.failure)
    }
}
