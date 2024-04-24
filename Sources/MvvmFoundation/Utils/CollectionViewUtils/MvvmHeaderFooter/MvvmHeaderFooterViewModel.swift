//
//  MvvmHeaderFooterViewModel.swift
//
//
//  Created by Daniil Vinogradov on 24/04/2024.
//

import Foundation

class MvvmHeaderFooterViewModel: MvvmViewModelWith<String?> {
    @Published var title: String?

    override func prepare(with model: String?) {
        title = model
    }
}
