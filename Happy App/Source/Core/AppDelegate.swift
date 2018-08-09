//
//  AppDelegate.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 26/04/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import UIKit
import RxCocoa

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptionslaunchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let tokens = url.host?.split(separator: "=")
        if let tokens = tokens, tokens.count == 2 && tokens.first == "happinessPercentage", let value = Int(tokens[1]) {
            NotificationCenter.default.post(name: Notification.Name.submitHappinessPercentage, object: nil, userInfo: ["happinessPercentage": value])
        }

        return true
    }
}
