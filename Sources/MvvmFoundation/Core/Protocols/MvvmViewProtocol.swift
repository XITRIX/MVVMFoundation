//
//  MvvmViewProtocol.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation
import SwiftUI

@MainActor
public protocol MvvmViewProtocol {
    associatedtype ViewModel: MvvmViewModelProtocol
    var viewModel: ViewModel { get }
}

@available(iOS 14.0, *)
@MainActor
public protocol MvvmSwiftUIViewProtocol: MvvmViewCellProtocol, View {
    var title: String { get set }
    init(viewModel: ViewModel)
}
