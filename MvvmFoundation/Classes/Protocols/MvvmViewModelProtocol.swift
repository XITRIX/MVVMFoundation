//
//  MvvmViewModelProtocol.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation
import RxRelay
import RxSwift

public protocol MvvmViewModelProtocol: MvvmAssociatedObjectHolderProtocol, Hashable {
    var title: BehaviorRelay<String?> { get }
    var navigationService: NavigationProtocol! { get }
    var parent: (any MvvmViewModelProtocol)? { get }

    init()

    func willAppear()
    func willDisappear()

    func setNavigationService(_ navigationService: NavigationProtocol)
    func setParent(_ parent: (any MvvmViewModelProtocol)?) -> Self
}
