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

    open class var style: UITableView.Style {
        if #available(iOS 13.0, *) {
            return .insetGrouped
        } else {
            return .grouped
        }
    }

    open var toolbarHidden: Bool { toolbarItems.isNilOrEmpty }

    public init() {
        super.init(style: Self.style)
    }

    override public init(style: UITableView.Style) {
        super.init(style: style)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @available(*, unavailable)
    override open func viewDidLoad() {
        super.viewDidLoad()
        viewModel.appear()
        setupView()
        binding()
    }

    override open func viewWillAppear(_ animated: Bool) {
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

        // Remove old
        old?.willMove(toParent: nil)
        tableView.backgroundView = nil
        old?.removeFromParent()

        // Add new one
        guard let overlay = overlay else { return }

        addChild(overlay)
        overlay.view.frame = view.bounds
        overlay.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.backgroundView = overlay.view
        overlay.didMove(toParent: self)
    }
}
