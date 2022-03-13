//
//  MVVM.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 03.11.2021.
//

import Foundation

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

    open func registerContainer() {
        // Register ViewController Overlays
        container.register { LoadingOverlayViewController() }
        container.register { ErrorOverlayViewController() }
    }

    open func registerRouting() {}
}
