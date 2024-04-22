//
//  NSObject+Container.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import Foundation

public protocol Resolvable {
    static func resolve() -> Self
}

public extension Resolvable {
    static func resolve() -> Self {
        Mvvm.shared.container.resolve()
    }
}

extension NSObject: Resolvable { }
extension MvvmViewModel: Resolvable { }
