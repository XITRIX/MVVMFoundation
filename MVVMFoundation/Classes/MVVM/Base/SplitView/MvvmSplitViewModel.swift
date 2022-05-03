//
//  MvvmSplitViewModel.swift
//  ReManga
//
//  Created by Даниил Виноградов on 11.12.2021.
//

import Foundation
import Bond

public protocol MvvmSplitViewModelProtocol: MvvmViewModel {
    var primaryViewModel: (model: MvvmViewModel.Type, wrappedInNavigation: Bool) { get }
    var secondaryViewModel: (model: MvvmViewModel.Type, wrappedInNavigation: Bool)? { get }
}
