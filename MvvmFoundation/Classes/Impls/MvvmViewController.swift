//
//  MvvmViewController.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import RxSwift
import UIKit

open class MvvmViewController<ViewModel: MvvmViewModelProtocol>: UIViewController, MvvmViewControllerProtocol {
    public let disposeBag = DisposeBag()
    public let viewModel: ViewModel

    override open var nibName: String? {
        Self.classNameWithoutGenericType
    }

    public required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.navigationService = self

        viewModel.title.bind(to: rx.title).disposed(by: disposeBag)
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

internal extension MvvmViewController {
    class var classNameWithoutGenericType: String {
        return "\(Self.self)".replacingOccurrences(of: "<\(ViewModel.self)>", with: "")
    }
}
