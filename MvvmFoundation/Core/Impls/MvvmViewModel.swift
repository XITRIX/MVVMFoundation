//
//  MvvmViewModel.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation
import Combine

//@MainActor
open class MvvmViewModel: MvvmViewModelProtocol {
    private let uuid = UUID()
    public var parent: (any MvvmViewModelProtocol)?

    public let disposeBag = DisposeBag()
//    public let title = CurrentValueSubject<String?, Never>(nil)
    public var navigationService: (() -> NavigationProtocol?)?
    public required init() {}

    public func setParent(_ parent: (any MvvmViewModelProtocol)?) -> Self {
        self.parent = parent
        return self
    }

    open func willAppear() {}

    open func didAppear() {}

    open func willDisappear() {}

    open func didDisappear() {}

    public func setNavigationService(_ navigationService: @escaping () -> NavigationProtocol?) {
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
