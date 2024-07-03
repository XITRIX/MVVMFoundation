//
//  MvvmHostingViewController.swift
//
//
//  Created by Даниил Виноградов on 03.07.2024.
//

import Combine
import SwiftUI
import UIKit

@available(iOS 14.0, *)
@MainActor
open class MvvmHostingViewController<View: MvvmSwiftUIViewProtocol>: UIHostingController<View>, MvvmViewControllerProtocol {
    public let disposeBag = DisposeBag()
    public nonisolated let viewModel: View.ViewModel

    required public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(rootView: View(viewModel: viewModel))

        if viewModel.navigationService == nil {
            viewModel.setNavigationService { [unowned self] in self }
        }
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.willAppear()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didAppear()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.willDisappear()
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.didDisappear()
    }
}
