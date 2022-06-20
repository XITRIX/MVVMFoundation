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
    func navigate<TVM: MvvmViewModel>(from controller: UIViewController, to targetViewModel: TVM.Type, with type: NavigationType) {
        let vc = resolve(viewModel: targetViewModel)
        navigate(from: controller, to: vc, with: type)
    }

    func navigate<M, TVM: MvvmViewModelWith<M>>(from controller: UIViewController, to targetViewModel: TVM.Type, prepare model: M, with type: NavigationType) {
        let vc = resolve(viewModel: TVM.self, prepare: model)
        navigate(from: controller, to: vc, with: type)
    }

    func navigate(from controller: UIViewController, to targetController: UIViewController, with type: NavigationType) {
        switch type {
        case .push:
            controller.show(targetController, sender: controller)
        case .detail:
            targetController.isSecondary = true
            controller.showDetailViewController(targetController, sender: controller)
        case .modal(let wrapInNavigation):
            if wrapInNavigation {
                let nvc = UINavigationController.safeResolve()
                nvc.viewControllers = [targetController]
                controller.present(nvc, animated: true)
            } else {
                controller.present(targetController, animated: true)
            }
        }
    }
}
