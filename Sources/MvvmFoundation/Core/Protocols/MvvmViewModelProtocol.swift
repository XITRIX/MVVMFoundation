//
//  MvvmViewModelProtocol.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation
import Combine

public protocol MvvmViewModelProtocol: MvvmAssociatedObjectHolderProtocol, Hashable, Sendable {
//    var title: CurrentValueSubject<String?, Never> { get }
    var navigationService: (() -> NavigationProtocol?)? { get }
    var parent: (any MvvmViewModelProtocol)? { get }

    init()

    func willAppear()
    func didAppear()
    func willDisappear()
    func didDisappear()

    func setNavigationService(_ navigationService: @escaping () -> NavigationProtocol?)
    func setParent(_ parent: (any MvvmViewModelProtocol)?) -> Self
}
