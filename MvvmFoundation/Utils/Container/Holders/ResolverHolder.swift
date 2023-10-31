//
//  ResolverHolder.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

public class ResolverHolder: HolderProtocol {
    let factory: () -> Any
    public var getter: Any {
        factory()
    }

    init(factory: @escaping () -> Any) {
        self.factory = factory
    }
}
