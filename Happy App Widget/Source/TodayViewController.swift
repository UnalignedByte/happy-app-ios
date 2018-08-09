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
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = String.forTranslation(.titleBefore)
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }

    @IBAction func voteButtonPressed(_ sender: UIButton) {
        let happinessPercentage = sender.tag * 25
        guard let url = URL(string: "happyapp://happinessPercentage=\(happinessPercentage)") else { return }
        extensionContext?.open(url, completionHandler: nil)
    }
}
