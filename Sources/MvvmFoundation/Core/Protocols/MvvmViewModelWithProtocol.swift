//
//  MvvmViewModelWithProtocol.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation

@MainActor
public protocol MvvmViewModelWithProtocol: MvvmViewModelProtocol {
    associatedtype Model
    func prepare(with model: Model)
}

@MainActor
extension MvvmViewModelWithProtocol {
    public init(with model: Model) {
        self.init()
        prepare(with: model)
    }
}

