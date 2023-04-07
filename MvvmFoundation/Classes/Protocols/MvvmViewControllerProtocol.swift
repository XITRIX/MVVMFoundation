//
//  MvvmViewControllerProtocol.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

public protocol MvvmViewControllerProtocol: MvvmViewProtocol, UIViewController {
    var viewModel: ViewModel { get }
    init(viewModel: ViewModel)
}
