//
//  Router+Navigation.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 04.11.2021.
//

import UIKit

public extension Router {
    enum NavigationType {
        case push
        case detail
        case modal(wrapInNavigation: Bool)
    }

    func dismiss<FVM: MvvmViewModelProtocol>(from fromViewModel: FVM, completion: (() -> ())? = nil) {
        guard let fvc = fromViewModel.attachedView
        else { return }

        if fvc.isModal {
            fvc.dismiss(animated: true, completion: completion)
        } else {
            fvc.navigationController?.popViewController(animated: true)
        }
    }

    func dismissToRoot<FVM: MvvmViewModelProtocol>(from fromViewModel: FVM, completion: (() -> ())? = nil) {
        guard let fvc = fromViewModel.attachedView
        else { return }

        if fvc.isModal {
            fvc.dismiss(animated: true, completion: completion)
        } else {
            if fvc.isSecondary == true,
               let svc = fvc.splitViewController as? MvvmSplitViewControllerProtocol,
                !svc.isCollapsed
            {
                svc.viewControllers[1] = svc.createEmptyViewController()
            } else {
                fvc.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

// MARK: - Untargeted navigation
public extension Router {
    func navigate<TVM: MvvmViewModel>(to targetViewModel: TVM.Type, with type: NavigationType) {
        guard let fvc = topMostView
        else { return }

        navigate(from: fvc, to: targetViewModel, with: type)
    }

    func navigate<M, TVM: MvvmViewModelWith<M>>(to targetViewModel: TVM.Type, prepare model: M, with type: NavigationType) {
        guard let fvc = topMostView
        else { return }

        navigate(from: fvc, to: targetViewModel, prepare: model, with: type)
    }
}

// MARK: - Targeted navigation
public extension Router {
    func navigate<FVM: MvvmViewModelProtocol, TVM: MvvmViewModel>(from fromViewModel: FVM, to targetViewModel: TVM.Type, with type: NavigationType) {
        guard let fvc = fromViewModel.attachedView
        else { return }

        navigate(from: fvc, to: targetViewModel, with: type)
    }

    func navigate<M, FVM: MvvmViewModelProtocol, TVM: MvvmViewModelWith<M>>(from fromViewModel: FVM, to targetViewModel: TVM.Type, prepare model: M, with type: NavigationType) {
        guard let fvc = fromViewModel.attachedView
        else { return }

        navigate(from: fvc, to: targetViewModel, prepare: model, with: type)
    }
}

private extension Router {
    func navigate<TVM: MvvmViewModel>(from controller: UIViewController? = nil, to targetViewModel: TVM.Type, with type: NavigationType) {
        guard let fvc = controller
        else { return }

        let vc = resolve(viewModel: targetViewModel)

        switch type {
        case .push:
            fvc.show(vc, sender: fvc)
        case .detail:
            vc.isSecondary = true
            fvc.showDetailViewController(vc, sender: fvc)
        case .modal(let wrapInNavigation):
            if wrapInNavigation {
                let nvc = UINavigationController.safeResolve()
                nvc.viewControllers = [vc]
                fvc.present(nvc, animated: true)
            } else {
                fvc.present(vc, animated: true)
            }
        }
    }

    func navigate<M, TVM: MvvmViewModelWith<M>>(from controller: UIViewController? = nil, to targetViewModel: TVM.Type, prepare model: M, with type: NavigationType) {
        guard let fvc = controller
        else { return }

        let vc = resolve(viewModel: TVM.self, prepare: model)

        switch type {
        case .push:
            fvc.show(vc, sender: fvc)
        case .detail:
            vc.isSecondary = true
            fvc.showDetailViewController(vc, sender: fvc)
        case .modal(let wrapInNavigation):
            if wrapInNavigation {
                let nvc = UINavigationController.safeResolve()
                nvc.viewControllers = [vc]
                fvc.present(nvc, animated: true)
            } else {
                fvc.present(vc, animated: true)
            }
        }
    }
}
