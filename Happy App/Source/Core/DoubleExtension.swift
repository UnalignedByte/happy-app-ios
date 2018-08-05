//
//  DoubleExtension.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 02/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

infix operator §
func § (lhs: Double, rhs: Double) -> Bool {
    return abs(lhs - rhs) < 0.001
}
