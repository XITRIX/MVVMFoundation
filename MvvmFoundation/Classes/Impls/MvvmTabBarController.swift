//
//  MvvmTabBarController.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 12.04.2023.
//

import RxSwift
import UIKit

open class MvvmTabBarController<ViewModel: MvvmTabBarViewModelProtocol>: UITabBarController, MvvmViewControllerProtocol {
    public let disposeBag = DisposeBag()
    public let viewModel: ViewModel

    override open var nibName: String? {
        Self.classNameWithoutGenericType
    }

    public required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.setNavigationService(self)

        bind(in: disposeBag) {
            rx.title <- viewModel.title
            viewModel.tabs.bind { [unowned self] tabs in
                applyTabs(tabs)
            }
        }
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.willAppear()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.willDisappear()
    }
}

private extension MvvmTabBarController {
    func applyTabs(_ tabs: [MvvmTabBarItem]) {
        let vcs = tabs
            .compactMap {
                let vc = Mvvm.shared.router.resolve($0.viewModel) as UIViewController
                vc.tabBarItem = UITabBarItem(title: $0.viewModel.title.value, image: $0.image, selectedImage: $0.selectedImage)
                return vc
            }
            .map {
                let nvc = UINavigationController(rootViewController: $0)
                nvc.navigationBar.prefersLargeTitles = true
                return nvc
            }
        
        self.viewControllers = vcs
    }
}
