//
//  MvvmSceneDelegate.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit
import RxSwift

open class MvvmSceneDelegate: UIResponder, UIWindowSceneDelegate {
    public var window: UIWindow?
    public let disposeBag = DisposeBag()

    open func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        initialSetup()

        register(in: Mvvm.shared.container)
        routing(in: Mvvm.shared.router)

        window.rootViewController = resolveRootVC()
        window.makeKeyAndVisible()

        binding()
    }

    open func initialSetup() {}

    open func register(in container: Container) {}

    open func routing(in router: Router) {}

    open func binding() {}

    open func resolveRootVC() -> UIViewController {
        fatalError("resolveRootVC() has not been implemented")
    }
}
