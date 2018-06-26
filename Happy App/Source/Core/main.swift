//
//  main.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 02/06/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil

var appDelegateClassString: String!
if isRunningTests {
    appDelegateClassString = NSStringFromClass(UnitTestsAppDelegate.self)
} else {
    appDelegateClassString = NSStringFromClass(AppDelegate.self)
}

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClassString)
