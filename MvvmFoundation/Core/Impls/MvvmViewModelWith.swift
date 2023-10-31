//
//  MvvmViewModelWith.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation

@MainActor
open class MvvmViewModelWith<Model>: MvvmViewModel, MvvmViewModelWithProtocol {
    open func prepare(with model: Model) {}
}
