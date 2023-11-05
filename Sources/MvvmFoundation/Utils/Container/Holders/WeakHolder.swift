//
//  WeakHolder.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 07.04.2023.
//

import Foundation

public class WeakHolder: HolderProtocol {
    var factory: () -> AnyObject
    weak var instance: AnyObject?
    public var getter: Any {
        guard let instance
        else {
            let holder = factory()
            instance = holder
            return holder
        }

        return instance
    }

    init(factory: @escaping () -> AnyObject) {
        self.factory = factory
    }
}

