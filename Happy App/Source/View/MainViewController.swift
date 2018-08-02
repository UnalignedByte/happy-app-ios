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
    @IBOutlet private var voteButtons: [UIButton]!
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
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] opacity in
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                    self?.selectionAreaView.alpha = CGFloat(opacity)
                }, completion: nil)
                self?.selectionAreaView.isUserInteractionEnabled = opacity § 1.0
            }).disposed(by: disposeBag)

        voteButtons.forEach { button in
            button.rx.tap.subscribe(onNext: { [weak self] _ in
                let buttonTag = button.tag
                self?.viewModel?.voteButtonPressed(atIndex: buttonTag)
            }).disposed(by: disposeBag)
        }
    }

    private func setupResultsArea() {
        guard let viewModel = viewModel else { fatalError() }
        viewModel.resultsHint.bind(to: resultsHintLabel.rx.text).disposed(by: disposeBag)
        viewModel.resultsAreaOpacity
            .map { CGFloat($0) }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] opacity in
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                    self?.resultsAreaView.alpha = CGFloat(opacity)
                }, completion: nil)
            }).disposed(by: disposeBag)

        resultsAreaView.layer.cornerRadius = 24.0
    }
}
