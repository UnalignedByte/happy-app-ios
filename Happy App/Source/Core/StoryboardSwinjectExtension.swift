//
//  StoryboardSwinjectExtension.swift
//  Happy App
//
//  Created by Rafal Grodzinski on 02/08/2018.
//  Copyright © 2018 UnalignedByte. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc static func setup() {
        defaultContainer.storyboardInitCompleted(MainViewController.self) { r, c in
            let viewModel = r.resolve(MainViewModelProtocol.self)
            c.viewModel = viewModel
        }

        defaultContainer.register(MainViewModelProtocol.self) { r in
            MainViewModel()
        }
    }
}
