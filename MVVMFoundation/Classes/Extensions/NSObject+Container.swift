//
//  MvvmViewController+Router.swift
//  ReManga
//
//  Created by Даниил Виноградов on 10.11.2021.
//

import Foundation

public extension NSObject {
    static func resolve() -> Self {
        MVVM.shared.container.resolve()
    }

    static func safeResolve() -> Self {
        MVVM.shared.container.safeResolve() ?? Self.init()
    }
}
