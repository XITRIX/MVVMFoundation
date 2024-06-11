//
//  MvvmViewModel.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation
import Combine

@available(iOS 13.0, *)
open class MvvmViewModel: MvvmViewModelProtocol {
    private let uuid = UUID()
    public weak var parent: (any MvvmViewModelProtocol)?

    public let disposeBag = DisposeBag()
//    public let title = CurrentValueSubject<String?, Never>(nil)
    public private(set) var navigationService: (() -> NavigationProtocol?)?
    public required init() {}

    public func setParent(_ parent: (any MvvmViewModelProtocol)?) -> Self {
        self.parent = parent
        return self
    }

    open func willAppear() {}

    open func didAppear() {}

    open func willDisappear() {}

    open func didDisappear() {}

    open func setNavigationService(_ navigationService: @escaping () -> NavigationProtocol?) {
        self.navigationService = navigationService
    }

    public static func == (lhs: MvvmViewModel, rhs: MvvmViewModel) -> Bool {
        lhs.isEqual(to: rhs)
    }

    open func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    open func isEqual(to other: MvvmViewModel) -> Bool {
        hashValue == other.hashValue
    }
}
