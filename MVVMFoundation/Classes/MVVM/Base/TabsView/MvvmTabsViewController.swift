//
//  MvvmTabsViewController.swift
//  ReManga
//
//  Created by Даниил Виноградов on 06.11.2021.
//

import UIKit

open class MvvmTabsViewController<ViewModel: MvvmTabsViewModelProtocol>: UITabBarController, MvvmViewControllerProtocol {
    public var _viewModel: MvvmViewModelProtocol!
    var viewModel: ViewModel { _viewModel as! ViewModel }
    private var shown = false

    open override var navigationController: UINavigationController? {
        selectedViewController as? UINavigationController
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !shown {
            shown = true

            viewModel.viewModels.observeNext { [unowned self] viewModels in
                let viewControllers = viewModels.collection.map { model -> UIViewController in
                    let vc = model.item.resolveView()
                    let nvc = UINavigationController.safeResolve()
                    nvc.viewControllers = [vc]
                    nvc.tabBarItem.title = model.title
                    nvc.tabBarItem.image = model.image
                    nvc.tabBarItem.selectedImage = model.selectedImage
                    return nvc
                }
                
                setViewControllers(viewControllers, animated: false)
            }.dispose(in: bag)
        }
    }
}
