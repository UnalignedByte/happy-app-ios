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
        }.initCompleted { r, c in
            let viewModel = c as! MainViewModel
            viewModel.userManager = r.resolve(UserManagerProtocol.self)
        }

        defaultContainer.register(UserManagerProtocol.self) { r in
            UserManager()
        }.initCompleted { r, c in
            let userManager = c as! UserManager
            userManager.dataManager = r.resolve(DataManagerProtocol.self)
            userManager.timeManager = r.resolve(TimeManagerProtocol.self)
            userManager.persistenceManager = r.resolve(PersistenceManager.self)
        }

        defaultContainer.register(DataManagerProtocol.self) { r in
            DataManager()
        }.initCompleted { r, c in
            let dataManager = c as! DataManager
            dataManager.dataFetcher = r.resolve(DataFetcherProtocol.self)
            dataManager.dataPusher = r.resolve(DataPusherProtocol.self)
        }

        defaultContainer.register(TimeManagerProtocol.self) { r in
            TimeManager()
        }

        defaultContainer.register(PersistenceManager.self) { r in
            PersistenceManager()
        }

        defaultContainer.register(DataFetcherProtocol.self) { r in
            DataFetcher()
        }.initCompleted { r, c in
            let dataFetcher = c as! DataFetcher
            dataFetcher.webApi = r.resolve(WebApiProtocol.self)
        }

        defaultContainer.register(DataPusherProtocol.self) { r in
            DataPusher()
        }.initCompleted { r, c in
            let dataPusher = c as! DataPusher
            dataPusher.webApi = r.resolve(WebApiProtocol.self)
        }

        defaultContainer.register(WebApiProtocol.self) { r in
            WebApi()
        }
    }
}
