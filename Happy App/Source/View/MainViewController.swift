//
//  MainView.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 02/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import RxCocoa
import RxSwift
import CoreImage

class MainViewController: UIViewController {
    @IBOutlet private weak var backgroundImageTop: UIImageView!
    @IBOutlet private weak var backgroundImageBottom: UIImageView!

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var resultsHintLabel: UILabel!
    @IBOutlet private weak var selectionAreaView: UIView!
    @IBOutlet private weak var resultsAreaView: UIView!
    @IBOutlet private var voteButtons: [UIButton]!

    @IBOutlet private var resultsLabels: [UILabel]!
    @IBOutlet private var resultsYouLabel: UILabel!
    @IBOutlet private var resultsWorldLabel: UILabel!
    @IBOutlet private var resultsTodayLabel: UILabel!
    @IBOutlet private var resultsAllTimeLabel: UILabel!
    @IBOutlet private var resultYouTodayLabel: UILabel!
    @IBOutlet private var resultYouAllTimeLabel: UILabel!
    @IBOutlet private var resultWorldTodayLabel: UILabel!
    @IBOutlet private var resultWorldAllTimeLabel: UILabel!

    private var ciContext: CIContext!
    private var topColorFilter: CIFilter!
    private var topMaskFilter: CIFilter!
    private var bottomColorFilter: CIFilter!
    private var bottomMaskFilter: CIFilter!

    private let disposeBag = DisposeBag()
    var viewModel: MainViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupTitle()
        setupSelectionArea()
        setupResultsArea()
    }

    private func setupBackground() {
        guard let metalDevice = MTLCreateSystemDefaultDevice() else { fatalError() }
        ciContext = CIContext(mtlDevice: metalDevice)

        let imgNumber = Int.random(in: 0...1)

        topColorFilter = CIFilter(name: "CIConstantColorGenerator")
        guard let uiTopMaskImage = UIImage(named: "Background \(imgNumber) Top") else { fatalError() }
        guard let topMaskImage = CIImage(image: uiTopMaskImage) else { fatalError() }
        topMaskFilter = CIFilter(name: "CIBlendWithMask", parameters: [kCIInputMaskImageKey: topMaskImage])

        Observable<Int>.interval(1.0/30.0, scheduler: ConcurrentDispatchQueueScheduler(qos: .default))
            .map { [weak self] in
                return self?.colorFor(time: $0)
            }.map { [weak self] color in
                if let self = self, let color = color {
                    return self.colorize(context: self.ciContext, colorFilter: self.topColorFilter, maskFilter: self.topMaskFilter, color: color)
                } else {
                    return UIImage()
                }
            }.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (image) in
                self?.backgroundImageTop.image = image
            }).disposed(by: disposeBag)

        bottomColorFilter = CIFilter(name: "CIConstantColorGenerator")
        guard let uiBottomMaskImage = UIImage(named: "Background \(imgNumber) Bottom") else { fatalError() }
        guard let bottomMaskImage = CIImage(image: uiBottomMaskImage) else { fatalError() }
        bottomMaskFilter = CIFilter(name: "CIBlendWithMask", parameters: [kCIInputMaskImageKey: bottomMaskImage])

        Observable<Int>.interval(1.0/28.0, scheduler: ConcurrentDispatchQueueScheduler(qos: .default))
            .map { [weak self] in
                return self?.colorFor(time: $0 + 150)
            }.map { [weak self] color in
                if let self = self, let color = color {
                    return self.colorize(context: self.ciContext, colorFilter: self.bottomColorFilter, maskFilter: self.bottomMaskFilter, color: color)
                } else {
                    return UIImage()
                }
            }.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (image) in
                self?.backgroundImageBottom.image = image
            }).disposed(by: disposeBag)
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
        resultsAreaView.layer.borderWidth = 4.0
        resultsAreaView.layer.borderColor = UIColor(white: 1.0, alpha: 0.35).cgColor

        resultsLabels.forEach { label in
            viewModel.resultsOpacity
                .map { CGFloat($0) }
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { opacity in
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                        label.alpha = opacity
                    }, completion: nil)
                }).disposed(by: disposeBag)
        }

        viewModel.resultYouToday.bind(to: resultYouTodayLabel.rx.text).disposed(by: disposeBag)
        viewModel.resultYouAllTime.bind(to: resultYouAllTimeLabel.rx.text).disposed(by: disposeBag)
        viewModel.resultWorldToday.bind(to: resultWorldTodayLabel.rx.text).disposed(by: disposeBag)
        viewModel.resultWorldAllTime.bind(to: resultWorldAllTimeLabel.rx.text).disposed(by: disposeBag)
    }

    private func colorFor(time: Int) -> UIColor {
        return UIColor(hue: CGFloat(time % 300)/300.0, saturation: 0.9, brightness: 0.9, alpha: 1.0)
    }

    private func colorize(context: CIContext, colorFilter: CIFilter, maskFilter: CIFilter, color: UIColor) -> UIImage {
        colorFilter.setValue(CIColor(color: color), forKey: kCIInputColorKey)
        maskFilter.setValue(colorFilter.outputImage, forKey: kCIInputImageKey)
        guard let ciImage = maskFilter.outputImage else { fatalError() }
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { fatalError() }
        return UIImage(cgImage: cgImage)
    }
}
