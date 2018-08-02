//
//  MainViewModel.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 02/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxSwift

protocol MainViewModelProtocol {
    var title: Observable<String> { get }
}

class MainViewModel {
    var title: Observable<String> {
        return Observable.just(String.forTranslation(String.Translation.titleBefore))
    }
}
