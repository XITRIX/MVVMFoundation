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

    public let disposeBag = DisposeBag()
    public var title = BehaviorRelay<String?>(value: nil)
    public weak var navigationService: NavigationProtocol!
    public required init() {
        binding()
    }
    open func binding() {}

    open func willAppear() {}
    open func willDisappear() {}

    public static func == (lhs: MvvmViewModel, rhs: MvvmViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
