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
    var resultsHint: Observable<String> { get }
    var selectionAreaOpacity: Observable<Double> { get }
    var resultsAreaOpacity: Observable<Double> { get }
}

class MainViewModel {
    var title: Observable<String> {
        return Observable.just(String.forTranslation(.titleBefore))
    }

    var resultsHint: Observable<String> {
        return Observable.just(String.forTranslation(.resultsHint))
    }

    var selectionAreaOpacity: Observable<Double> {
        return Observable.just(1.0)
    }

    var resultsAreaOpacity: Observable<Double> {
        return Observable.just(1.0)
    }
}
