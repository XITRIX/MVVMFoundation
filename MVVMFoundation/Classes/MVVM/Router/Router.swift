//
//  Router.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 03.11.2021.
//

import Foundation
import UIKit

struct MvvmRootModel {
    var rootModel: String
    var wrappedInNavigation: Bool
}

public class Router {
    private let container: Container
    private var map = [String: Any]()
    private var rootModel: MvvmRootModel?
    private var rootWindow: UIWindow?

    public init(container: Container) {
        self.container = container
    }
}

public extension Router {
    var rootView: UIViewController? {
        rootWindow?.rootViewController
    }
    var topMostView: UIViewController? {
        var root = rootWindow?.rootViewController
        while root?.presentedViewController != nil {
            root = root?.presentedViewController
        }

        while root?.children.first != nil {
            root = root?.children.first
        }

        return root
    }
}

// MARK: - Public
public extension Router {
    func registerRoot(_ rootModel: MvvmViewModelProtocol.Type, wrappedInNavigation: Bool = false) {
        self.rootModel = MvvmRootModel(rootModel: "\(rootModel)", wrappedInNavigation: wrappedInNavigation)
    }

    func resolveRoot(in window: UIWindow) {
        guard let rootModel = rootModel,
              let resolver = map["\(rootModel.rootModel)"]
        else { return }

        let viewModel = container.resolve(id: rootModel.rootModel) as MvvmViewModelProtocol
        let vc = container.resolve(id: "\(resolver)") as MvvmViewControllerProtocol
        vc.setViewModel(viewModel)

        if rootModel.wrappedInNavigation {
            let nvc = UINavigationController.safeResolve()
            nvc.viewControllers = [vc]
            window.rootViewController = nvc
        } else {
            window.rootViewController = vc
        }
        rootWindow = window
    }
}

// MARK: - MvvmViewController
public extension Router {
    func register<VM: MvvmViewModelProtocol, VC: MvvmViewControllerProtocol>(viewModel: VM.Type, viewController: VC.Type) {
        map["\(viewModel)"] = viewController
    }

    func resolve<VM: MvvmViewModelProtocol>(viewModel: VM.Type) -> MvvmViewControllerProtocol {
        guard let resolver = map["\(viewModel)"] else {
            fatalError("\(viewModel) is not registered")
        }

        let viewModel = container.resolve(type: viewModel)
        let vc = container.resolve(id: "\(resolver)") as MvvmViewControllerProtocol
        vc.setViewModel(viewModel)
        return vc
    }

    func resolve<M, VM: MvvmViewModelWithProtocol>(viewModel: VM.Type, prepare model: M) -> MvvmViewControllerProtocol where VM.Model == M {
        guard let resolver = map["\(viewModel)"] else {
            fatalError("\(viewModel) is not registered")
        }

        let viewModel = container.resolve(type: VM.self)
        let vc = container.resolve(id: "\(resolver)") as MvvmViewControllerProtocol
        viewModel.prepare(with: model)
        vc.setViewModel(viewModel)
        return vc
    }
}
