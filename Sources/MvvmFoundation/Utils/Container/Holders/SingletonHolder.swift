//
//  SingletonHolder.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

public class SingletonHolder: HolderProtocol {
    var factory: () -> Any
    lazy var instance: Any = factory()
    public var getter: Any {
        instance
    }

    init(factory: @escaping () -> Any) {
        self.factory = factory
    }

    init(instance: Any) {
        self.factory = {}
        self.instance = instance
    }
}
