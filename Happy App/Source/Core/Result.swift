//
//  Result.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 05/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

enum Result {
    case success
    case failure

    static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            fallthrough
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
}
