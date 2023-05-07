//
//  MvvmViewModel.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation
import RxRelay
import RxSwift

open class MvvmViewModel: MvvmViewModelProtocol {
    private let uuid = UUID()
    public var parent: (any MvvmViewModelProtocol)?

    public let disposeBag = DisposeBag()
    public let title = BehaviorRelay<String?>(value: nil)
    public weak var navigationService: NavigationProtocol!
    public required init() {
        Task { await binding() }
    }

    public func setParent(_ parent: (any MvvmViewModelProtocol)?) -> Self {
        self.parent = parent
        return self
    }

    @MainActor
    open func binding() {}

    @MainActor
    open func willAppear() {}

    @MainActor
    open func willDisappear() {}

    public func setNavigationService(_ navigationService: NavigationProtocol) {
        self.navigationService = navigationService
    }

    @MainActor
    public static func == (lhs: MvvmViewModel, rhs: MvvmViewModel) -> Bool {
        lhs.isEqual(to: rhs)
    }

    @MainActor
    open func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    @MainActor
    open func isEqual(to other: MvvmViewModel) -> Bool {
        uuid == other.uuid
    }
}
