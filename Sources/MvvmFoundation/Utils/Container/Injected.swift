//
//  Injected.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

@propertyWrapper
public struct Injected<T> {
    let key: ContainerKey?
    public init(key: ContainerKey? = nil) {
        self.key = key
    }

    public lazy var wrappedValue = Mvvm.shared.container.resolve(key: key) as T
}
