//
//  MvvmCellViewModelWrapper.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

public struct MvvmCellViewModelWrapper<ViewModel: MvvmViewModelProtocol>: Hashable {
    public let viewModel: ViewModel!

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
