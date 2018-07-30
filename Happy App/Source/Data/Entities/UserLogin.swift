//
//  UserLogin.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 26/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

struct UserLogin {
    let key: String

    init(key: String) {
        self.key = key
    }
}

extension UserLogin: Codable {
}

extension UserLogin: Equatable {
}
