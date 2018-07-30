//
//  HappinessSubmission.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 08/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

struct HappinessSubmission {
    let happinessLevel: Int

    init(happinessLevel: Int) {
        self.happinessLevel = happinessLevel
    }
}

extension HappinessSubmission: Codable {
}

extension HappinessSubmission: Equatable {
}
