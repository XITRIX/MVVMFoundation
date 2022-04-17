//
//  MvvmViewModel.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 02.11.2021.
//

import Bond
import ReactiveKit
import UIKit

public protocol MvvmViewModelProtocol: DisposeBagProvider {
    var title: Observable<String?> { get }
    var attachedView: UIViewController! { get }
    var state: Observable<MvvmViewModelState> { get }

    func setAttachedView(_ viewController: UIViewController)
    
    func setup()
    func binding()
    func appear()
}

open class MvvmViewModel: MvvmViewModelProtocol {
    public let bag = DisposeBag()
    public let title = Observable<String?>(nil)
    public let state = Observable<MvvmViewModelState>(.done)

    public func setAttachedView(_ viewController: UIViewController) {
        guard attachedView == nil else { fatalError("attachedView cannot be reattached") }
        attachedView = viewController
    }

    open func setup() {}

    open func binding() {}

    open func appear() {}

    public private(set) weak var attachedView: UIViewController!

    public required init() {
        setup()
        binding()
    }
}
