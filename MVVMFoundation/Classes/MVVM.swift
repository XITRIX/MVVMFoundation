//
//  MVVM.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 03.11.2021.
//

import Foundation
import UIKit

open class MVVM {
    public private(set) static var shared: MVVM!

    public let container: Container
    public let router: Router

    public static func initialize(with mvvm: MVVM) {
        shared = mvvm
    }

    public init() {
        container = Container()
        router = Router(container: container)

        registerContainer()
        registerRouting()
    }

    public static func resolve(in window: UIWindow?) {
        guard let window = window else { return }
        MVVM.shared.router.resolveRoot(in: window)
        window.makeKeyAndVisible()
    }

    open func registerContainer() {
        // Register ViewController Overlays
        container.register { LoadingOverlayViewController() }
        container.register { ErrorOverlayViewController() }
    }

    open func registerRouting() {}
}

extension MVVM {
    public static func resolve<T: Any>(type: T.Type) -> T {
        shared.container.resolve(type: type)
    }

    public static func resolve<T: Any>() -> T {
        shared.container.resolve() as T
    }
}
