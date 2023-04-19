//
//  Navigation.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

public enum NavigationType {
    case show
    case present(wrapInNavigation: Bool)
    case detail
}

public protocol NavigationProtocol: UIViewController {
    func navigate(to navigationProtocol: any NavigationProtocol, by type: NavigationType)
    func dismiss()
}

extension UIViewController: NavigationProtocol {
    public func dismiss() {
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
        case .detail:
            showDetailViewController(navigationProtocol, sender: self)
        }
    }
}

public extension MvvmViewModelProtocol {
    func navigate<VM: MvvmViewModelProtocol>(to viewModel: VM.Type, by type: NavigationType) {
        navigationService.navigate(to: viewModel.resolveVC(), by: type)
    }

    func navigate<Model, VM: MvvmViewModelWithProtocol>(to viewModel: VM.Type, with model: Model, by type: NavigationType) where VM.Model == Model {
        let vc = viewModel.resolveVC(with: model)
        navigationService.navigate(to: vc, by: type)
    }

    func dismiss() {
        navigationService.dismiss()
    }
}
