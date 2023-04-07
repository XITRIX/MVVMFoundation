//
//  SceneDelegate.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import MvvmFoundation
import UIKit

class SceneDelegate: MvvmSceneDelegate {
    override func register(in container: Container) {
        container.registerSingleton { Api() as ApiProtocol }
    }

    override func routing(in router: Router) {
        router.register(MainScreenController<MainScreenViewModel>.self)
        router.register(FirstScreenController<FirstScreenViewModel>.self)
        router.register(FirstScreenController<FirstScreenViewModelWith>.self)

        router.register(SimpleCell<SimpleViewModel>.self)
    }

    override func resolveRootVC() -> UIViewController {
        let vc = MainScreenViewModel.resolveVC()
        return UINavigationController(rootViewController: vc)
    }
}

