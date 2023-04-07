//
//  MvvmViewModelWith.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

open class MvvmViewModelWith<Model>: MvvmViewModel, MvvmViewModelWithProtocol {
    open func prepare(with model: Model) {}
}
