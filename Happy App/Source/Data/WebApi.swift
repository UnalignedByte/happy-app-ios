//
//  WebApi.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 09/07/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import Foundation

protocol WebApiProtocol {
    var happinessStatusUrl: URL { get }
}

struct WebApi {
}

extension WebApi: WebApiProtocol {
    var happinessStatusUrl: URL { return URL(string: "https://unalignedbyte.com/api/happiness")! }
}
