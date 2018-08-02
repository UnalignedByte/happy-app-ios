//
//  MainView.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 02/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var resultsHintLabel: UILabel!
    @IBOutlet private weak var selectionAreaView: UIView!
    @IBOutlet private weak var resultsAreaView: UIView!
    private let disposeBag = DisposeBag()
    var viewModel: MainViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupSelectionArea()
        setupResultsArea()
    }

    private func setupTitle() {
        guard let viewModel = viewModel else { fatalError() }
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
    }

    private func setupSelectionArea() {
        guard let viewModel = viewModel else { fatalError() }
        viewModel.selectionAreaOpacity
            .map { CGFloat($0) }
            .bind(to: selectionAreaView.rx.alpha).disposed(by: disposeBag)
    }

    private func setupResultsArea() {
        guard let viewModel = viewModel else { fatalError() }
        viewModel.resultsHint.bind(to: resultsHintLabel.rx.text).disposed(by: disposeBag)
        viewModel.resultsAreaOpacity
            .map { CGFloat($0) }
            .bind(to: resultsAreaView.rx.alpha).disposed(by: disposeBag)

        resultsAreaView.layer.cornerRadius = 24.0
    }
}
