//
//  MvvmViewModelProtocol.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation
import RxRelay
import RxSwift

public protocol MvvmViewModelProtocol: Hashable {
    var title: BehaviorRelay<String?> { get }
    var navigationService: NavigationProtocol! { get }
    init()

    func willAppear()
    func willDisappear()

    func setNavigationService(_ navigationService: NavigationProtocol)
}
