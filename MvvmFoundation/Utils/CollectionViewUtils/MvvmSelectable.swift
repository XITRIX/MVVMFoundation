//
//  MvvmSelectable.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import Foundation

public protocol MvvmSelectableProtocol {
    var selectAction: (() -> Void)? { get }
}

public extension MvvmViewModel {
    var canBeSelected: Bool {
        (self as? MvvmSelectableProtocol)?.selectAction != nil
    }
}
