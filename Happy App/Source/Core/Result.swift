//
//  Result.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 05/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure

    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}

extension Result: Equatable where T: Equatable {
    static func == (lhs: Result<T>, rhs: Result<T>) -> Bool {
        switch (lhs, rhs) {
        case (.success(let lhsv), .success(let rhsv)):
                return lhsv == rhsv
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
}
