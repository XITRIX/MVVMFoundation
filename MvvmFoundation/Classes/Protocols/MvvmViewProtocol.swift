//
//  MvvmViewProtocol.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

public protocol MvvmViewProtocol: AnyObject {
    associatedtype ViewModel: MvvmViewModelProtocol
    var viewModel: ViewModel! { get }
}
