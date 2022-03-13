//
//  Holder.swift
//  DemoMVVM
//
//  Created by Даниил Виноградов on 02.11.2021.
//

import Foundation

public protocol HolderProtocol {
    var getter: Any { get }
}

public class ResolverHolder: HolderProtocol {
    let factory: ()->Any
    public var getter: Any {
        factory()
    }

    init(factory: @escaping ()->Any) {
        self.factory = factory
    }
}

public class SingletonHolder: HolderProtocol {
    var factory: ()->Any
    lazy var instance: Any = factory()
    public var getter: Any {
        instance
    }

    init(factory: @escaping ()->Any) {
        self.factory = factory
    }

    init(instance: Any) {
        self.factory = {}
        self.instance = instance
    }
}
