//
//  MvvmSplitViewController.swift
//  ReManga
//
//  Created by Даниил Виноградов on 11.12.2021.
//

import UIKit

open class MvvmSplitViewController<ViewModel: MvvmSplitViewModelProtocol>: UISplitViewController, MvvmViewControllerProtocol, UISplitViewControllerDelegate {
    public var _viewModel: MvvmViewModelProtocol!
    public var viewModel: ViewModel { _viewModel as! ViewModel }

    override open func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        preferredDisplayMode = .oneBesideSecondary
        var viewController: UIViewController = viewModel.primaryViewModel.model.resolveView()
        if viewModel.primaryViewModel.wrappedInNavigation {
            let nvc = UINavigationController.safeResolve()
            nvc.viewControllers = [viewController]
            viewController = nvc
        }
        viewControllers.append(viewController)
        if let secondary = viewModel.secondaryViewModel {
            var viewController: UIViewController = secondary.model.resolveView()
            if secondary.wrappedInNavigation {
                let nvc = UINavigationController.safeResolve()
                nvc.viewControllers = [viewController]
                viewController = nvc
            }
            viewControllers.append(viewController)
        } else {
            viewControllers.append(createEmptyViewController())
        }
    }

    open func createEmptyViewController() -> UIViewController {
        let vc = UIViewController()
        if #available(iOS 13.0, *) {
            vc.view.backgroundColor = .systemBackground
        } else {
            vc.view.backgroundColor = .white
        }
        return vc
    }

    override open func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        vc.isSecondary = true

        if isCollapsed {
            guard let from = sender as? UIViewController
            else { return }

            from.show(vc, sender: sender)
        } else {
            let nvc: UINavigationController
            if !viewControllers.isEmpty,
               let tnvc = viewControllers[1] as? UINavigationController
            { nvc = tnvc }
            else {
                nvc = UINavigationController.safeResolve()
                viewControllers[1] = nvc
            }

            nvc.setViewControllers([vc], animated: false)
        }
    }

    public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let snvc = secondaryViewController as? UINavigationController {
            primaryViewController.navigationController?.viewControllers.append(contentsOf: snvc.viewControllers)
        }
        return true
    }

    public func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        guard let nvc = primaryViewController.navigationController
        else { return nil }

        var controllers = nvc.viewControllers
        var firstControllersStack = [UIViewController]()

        while !controllers.isEmpty {
            if controllers.first?.isSecondary == true { break }
            firstControllersStack.append(controllers.remove(at: 0))
        }

        nvc.setViewControllers(firstControllersStack, animated: false)

        if !controllers.isEmpty {
            let snvc = UINavigationController.safeResolve()
            snvc.setViewControllers(controllers, animated: false)
            snvc.setToolbarHidden((controllers.last?.toolbarItems).isNilOrEmpty, animated: false)
            return snvc
        } else {
            return createEmptyViewController()
        }
    }
}
