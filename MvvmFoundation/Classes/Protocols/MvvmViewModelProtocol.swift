//
//  MvvmViewModelProtocol.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation
import RxRelay
import RxSwift

public protocol MvvmViewModelProtocol: AnyObject, Hashable {
    var title: BehaviorRelay<String?> { get }
    var navigationService: NavigationProtocol! { get set }
    init()

    func willAppear()
    func willDisappear()
}
