//
//  MvvmViewController.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 02.11.2021.
//

import UIKit

open class MvvmViewController<ViewModel: MvvmViewModelProtocol>: UIViewController, MvvmViewControllerProtocol {
    public var _viewModel: MvvmViewModelProtocol!
    public var viewModel: ViewModel { _viewModel as! ViewModel }
    public var overlay: UIViewController? {
        didSet { updateOverlay(oldValue) }
    }
    open var toolbarHidden: Bool { toolbarItems.isNilOrEmpty }

    @available(*, unavailable)
    open override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.appear()
        setupView()
        binding()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(toolbarHidden, animated: false)
    }

    open override func setToolbarItems(_ toolbarItems: [UIBarButtonItem]?, animated: Bool) {
        super.setToolbarItems(toolbarItems, animated: animated)
        navigationController?.setToolbarHidden(toolbarHidden, animated: animated)
    }

    open func setupView() {}
    open func binding() {
        viewModel.title.observeNext(with: { [unowned self] in title = $0 }).dispose(in: bag)
        viewModel.state.observeNext(with: { [unowned self] state in viewModelStateChanged(state) }).dispose(in: bag)
    }

    open func viewModelStateChanged(_ state: MvvmViewModelState) {
        switch state {
        case .done:
            overlay = nil
        case .processing:
            let loadingOverlay = LoadingOverlayViewController.resolve()
            loadingOverlay.backgroundColor = view.backgroundColor
            overlay = loadingOverlay
        case .error(let error):
            let errorOverlay = ErrorOverlayViewController.resolve()
            errorOverlay.error = error
            overlay = errorOverlay
        }
    }

    open func updateOverlay(_ old: UIViewController?) {
        if overlay == old { return }

        old?.remove()
        overlay?.add(to: self)
    }
}
