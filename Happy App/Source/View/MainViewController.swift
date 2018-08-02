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
            .map { CGFloat($0) }
            .bind(to: selectionAreaView.rx.alpha).disposed(by: disposeBag)

        //voteButtons.forEach {
            //$0.layer.cornerRadius = $0.layer.frame.width/2.0
            //$0.layer.borderWidth = 2.0
            //$0.layer.borderColor = UIColor(white: 0.967, alpha: 1.0).cgColor
            //$0.layer.shadowColor = UIColor.black.cgColor
            //$0.layer.shadowOpacity = 0.6
            //$0.layer.shadowRadius = 6.0
        //}
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
