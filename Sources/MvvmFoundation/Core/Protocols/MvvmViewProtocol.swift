//
//  MvvmViewProtocol.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation

@MainActor
public protocol MvvmViewProtocol {
    associatedtype ViewModel: MvvmViewModelProtocol
    var viewModel: ViewModel { get }
}
