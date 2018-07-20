//
//  None.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 20/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

class None: Equatable {
    static func == (lhs: None, rhs: None) -> Bool {
        return true
    }
}
