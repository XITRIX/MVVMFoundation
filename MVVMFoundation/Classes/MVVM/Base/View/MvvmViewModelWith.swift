//
//  MvvmViewModelProtocol.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 04.11.2021.
//

import Foundation
import ReactiveKit
import Bond

public protocol MvvmViewModelWithProtocol: MvvmViewModelProtocol {
    associatedtype Model

    func prepare(with item: Model)
}

open class MvvmViewModelWith<T>: MvvmViewModel, MvvmViewModelWithProtocol {
    public typealias Model = T

    open func prepare(with item: Model) {}
}
