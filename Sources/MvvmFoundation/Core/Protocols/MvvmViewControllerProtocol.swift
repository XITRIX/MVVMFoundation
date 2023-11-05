//
//  MvvmViewControllerProtocol.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import UIKit

@MainActor
public protocol MvvmViewControllerProtocol: MvvmViewProtocol, UIViewController {
    var viewModel: ViewModel { get }
    init(viewModel: ViewModel)
}
