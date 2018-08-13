//
//  TodayViewController.swift
//  Happy App Widget
//
//  Created by Rafal Grodzinski on 09/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    private static let kSubmissionDate = "submission_date"

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var heightConstraint: NSLayoutConstraint!
    private let userDefaults = UserDefaults(suiteName: "group.com.unalignedbyte.happyapp")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        setupView()
        completionHandler(NCUpdateResult.newData)
    }

    @IBAction func voteButtonPressed(_ sender: UIButton) {
        let happinessPercentage = sender.tag * 25
        guard let url = URL(string: "happyapp://happinessPercentage=\(happinessPercentage)") else { return }
        extensionContext?.open(url, completionHandler: nil)
    }

    private func setupView() {
        if canVote {
            titleLabel.text = String.forTranslation(.titleBefore)
            heightConstraint.isActive = false
        } else {
            titleLabel.text = String.forTranslation(.titleAfter)
            heightConstraint.isActive = true
        }
    }

    var canVote: Bool {
        guard let date = userDefaults.object(forKey: TodayViewController.kSubmissionDate) as? Date else {
            return true
        }

        guard let morningDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) else {
            return true
        }
        let result = date.compare(morningDate)
        return result != .orderedDescending
    }
}
