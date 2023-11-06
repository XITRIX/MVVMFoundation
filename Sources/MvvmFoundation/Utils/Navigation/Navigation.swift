//
//  Navigation.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import UIKit

public enum NavigationType {
    case show
    case present(wrapInNavigation: Bool)
    case detail(asRoot: Bool)
    case custom(transaction: (_ from: UIViewController, _ to: UIViewController) -> Void)
}

@MainActor
public protocol NavigationProtocol: UIViewController {
    func navigate(to navigationProtocol: any NavigationProtocol, by type: NavigationType)
    func dismiss()
    func pop()
}

extension UIViewController: NavigationProtocol {
    public func dismiss() {
        dismiss(animated: true)
    }

    public func pop() {
        if let navigationController,
           navigationController.viewControllers.count > 1
        {
            navigationController.popViewController(animated: true)
            return
        }
        dismiss(animated: true)
    }

    public func navigate(to navigationProtocol: any NavigationProtocol, by type: NavigationType) {
        switch type {
        case .show:
            show(navigationProtocol, sender: self)
        case .present(let wrapInNavigation):
            let vc: UIViewController
            if wrapInNavigation {
                let nvc = UINavigationController(rootViewController: navigationProtocol)
                nvc.modalPresentationStyle = navigationProtocol.modalPresentationStyle
                vc = nvc
            } else {
                vc = navigationProtocol
            }
            present(vc, animated: true)
        case .detail(let asRoot):
            if asRoot {
                let nvc = UINavigationController.resolve()
                nvc.viewControllers = [navigationProtocol]
                showDetailViewController(nvc, sender: self)
            } else {
                showDetailViewController(navigationProtocol, sender: self)
            }
        case .custom(let transaction):
            transaction(self, navigationProtocol)
        }
    }
}

@MainActor
public extension MvvmViewModelProtocol {
    func navigate<VM: MvvmViewModelProtocol>(to viewModel: VM.Type, by type: NavigationType) {
        let vc = viewModel.init().setParent(self).resolveVC()
        navigationService?()?.navigate(to: vc, by: type)
    }

    func navigate<Model, VM: MvvmViewModelWithProtocol>(to viewModel: VM.Type, with model: Model, by type: NavigationType) where VM.Model == Model {
        let vc = viewModel.init(with: model).setParent(self).resolveVC()
        navigationService?()?.navigate(to: vc, by: type)
    }

    func dismiss() {
        navigationService?()?.dismiss()
    }
}
