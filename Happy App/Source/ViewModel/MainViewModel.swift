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

    func voteButtonPressed(atIndex index: Int)
}

class MainViewModel {
    let titleVar = Variable<String>(String.forTranslation(.titleBefore))
    let selectionAreaOpacityVar = Variable<Double>(1.0)
    let resultsAreaOpacityVar = Variable<Double>(1.0)
}

extension MainViewModel: MainViewModelProtocol {
    var title: Observable<String> {
        return titleVar.asObservable()
    }

    var resultsHint: Observable<String> {
        return Observable.just(String.forTranslation(.resultsHint))
    }

    var selectionAreaOpacity: Observable<Double> {
        return selectionAreaOpacityVar.asObservable()
    }

    var resultsAreaOpacity: Observable<Double> {
        return resultsAreaOpacityVar.asObservable()
    }

    func voteButtonPressed(atIndex index: Int) {
        titleVar.value = String.forTranslation(.titleWaiting)
        selectionAreaOpacityVar.value = 0.5
        resultsAreaOpacityVar.value = 0.5
    }
}
