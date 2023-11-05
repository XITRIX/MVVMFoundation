//
//  NSObject+Container.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import Foundation

public extension NSObject {
    static func resolve() -> Self {
        Mvvm.shared.container.resolve()
    }
}
