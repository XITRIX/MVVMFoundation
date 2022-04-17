//
//  MvvmTableViewController.swift
//  ReManga
//
//  Created by Даниил Виноградов on 04.11.2021.
//

import UIKit

open class MvvmCollectionViewController<ViewModel: MvvmViewModelProtocol>: UICollectionViewController, MvvmViewControllerProtocol {
    public var _viewModel: MvvmViewModelProtocol!
    public var viewModel: ViewModel { _viewModel as! ViewModel }
    public var overlay: UIViewController? {
        didSet { updateOverlay(oldValue) }
    }
    
    public init() {
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }

    public override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
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
        collectionView.backgroundView = nil
        old?.removeFromParent()

        // Add new one
        guard let overlay = overlay else { return }

        addChild(overlay)
        overlay.view.frame = view.bounds
        overlay.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundView = overlay.view
        overlay.didMove(toParent: self)
    }
}
