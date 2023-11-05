//
//  MvvmViewController.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Combine
import UIKit

@available(iOS 13.0, *)
@MainActor
open class MvvmViewController<ViewModel: MvvmViewModelProtocol>: UIViewController, MvvmViewControllerProtocol {
    public let disposeBag = DisposeBag()
    public let viewModel: ViewModel

    override open var nibName: String? {
        let res = Self.classNameWithoutGenericType

        guard Bundle.main.path(forResource: res, ofType: "nib") != nil
        else { return nil }

        return res
    }

    public required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.setNavigationService { [unowned self] in self }

        disposeBag.bind {
//            rx.title <- viewModel.title
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

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didAppear()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.willDisappear()
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.didDisappear()
    }
}

internal extension MvvmViewControllerProtocol {
    static var classNameWithoutGenericType: String {
        return "\(Self.self)".replacingOccurrences(of: "<\(ViewModel.self)>", with: "")
    }
}
