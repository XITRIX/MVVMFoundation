//
//  MvvmViewModelWithProtocol.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

public protocol MvvmViewModelWithProtocol: MvvmViewModelProtocol {
    associatedtype Model
    func prepare(with model: Model)
}
