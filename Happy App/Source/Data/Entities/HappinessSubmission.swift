//
//  HappinessSubmission.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 08/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

struct HappinessSubmission {
    let happinessPercentage: Int

    init(happinessPercentage: Int) {
        self.happinessPercentage = happinessPercentage
    }
}

extension HappinessSubmission: Codable {
}

extension HappinessSubmission: Equatable {
}
