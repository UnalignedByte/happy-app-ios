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

    var resultsOpacity: Observable<Double> { get }
    var resultYouToday: Observable<String> { get }
    var resultYouAllTime: Observable<String> { get }
    var resultWorldToday: Observable<String> { get }
    var resultWorldAllTime: Observable<String> { get }

    func viewDidLoad()
    func voteButtonPressed(atIndex index: Int)
}

class MainViewModel {
    var userManager: UserManagerProtocol?

    private let disposeBag = DisposeBag()
    private let titleVar = Variable<String>(String.forTranslation(.titleBefore))
    private let resultsHintVar = Variable<String>(String.forTranslation(.resultsHint))
    private let selectionAreaOpacityVar = Variable<Double>(1.0)
    private let resultsAreaOpacityVar = Variable<Double>(1.0)
    private let resultsOpacityVar = Variable<Double>(0.0)
}

extension MainViewModel: MainViewModelProtocol {
    var title: Observable<String> {
        return titleVar.asObservable()
    }

    var resultsHint: Observable<String> {
        return resultsHintVar.asObservable()
    }

    var selectionAreaOpacity: Observable<Double> {
        return selectionAreaOpacityVar.asObservable()
    }

    var resultsAreaOpacity: Observable<Double> {
        return resultsAreaOpacityVar.asObservable()
    }

    var resultsOpacity: Observable<Double> {
        return resultsOpacityVar.asObservable()
    }

    var resultYouToday: Observable<String> {
        return Observable.just("+50%")
    }

    var resultYouAllTime: Observable<String> {
        return Observable.just("-27%")
    }

    var resultWorldToday: Observable<String> {
        return Observable.just("+4%")
    }

    var resultWorldAllTime: Observable<String> {
        return Observable.just("+14%")
    }

    func viewDidLoad() {
        guard let userManager = userManager else { fatalError() }
        userManager.logIn()
    }

    func voteButtonPressed(atIndex index: Int) {
        titleVar.value = String.forTranslation(.titleWaiting)
        selectionAreaOpacityVar.value = 0.5
        resultsAreaOpacityVar.value = 0.5

        let happinessPercentage = index * 25

        guard let userManager = userManager else { fatalError() }
        userManager.submit(happinessPercentage: happinessPercentage)
            .subscribe(onNext: { [weak self] result in
                if result == .success(None()) {
                    self?.titleVar.value = String.forTranslation(.titleAfter)
                    self?.selectionAreaOpacityVar.value = 0.0
                    self?.resultsAreaOpacityVar.value = 1.0
                    self?.resultsHintVar.value = ""
                    self?.resultsOpacityVar.value = 1.0
                } else {
                    self?.titleVar.value = String.forTranslation(.titleErrorSubmitting)
                    self?.selectionAreaOpacityVar.value = 1.0
                    self?.resultsAreaOpacityVar.value = 1.0
                    self?.resultsHintVar.value = String.forTranslation(.resultsHint)
                }
            }).disposed(by: disposeBag)
    }
}