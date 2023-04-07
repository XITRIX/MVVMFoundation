//
//  MvvmViewProtocol.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

public protocol MvvmViewProtocol {
    associatedtype ViewModel: MvvmViewModelProtocol
}
