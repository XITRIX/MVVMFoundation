//
//  MvvmTableViewController.swift
//  ReManga
//
//  Created by Даниил Виноградов on 04.11.2021.
//

import UIKit

open class MvvmTableViewController<ViewModel: MvvmViewModelProtocol>: UITableViewController, MvvmViewControllerProtocol {
    public var _viewModel: MvvmViewModelProtocol!
    public var viewModel: ViewModel { _viewModel as! ViewModel }
    public var overlay: UIViewController? {
        didSet { updateOverlay(oldValue) }
    }

    @available(*, unavailable)
    open override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.appear()
        setupView()
        binding()
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

        // Remove old
        old?.willMove(toParent: nil)
        self.tableView.backgroundView = nil
        old?.removeFromParent()

        // Add new one
        guard let overlay = overlay else { return }

        self.addChild(overlay)
        overlay.view.frame = self.view.bounds
        overlay.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.tableView.backgroundView = overlay.view
        overlay.didMove(toParent: self)
    }
}
