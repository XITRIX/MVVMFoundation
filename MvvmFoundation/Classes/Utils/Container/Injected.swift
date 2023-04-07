//
//  Injected.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

@propertyWrapper
public struct Injected<T> {
    public init() {}
    public let wrappedValue = Mvvm.shared.container.resolve() as T
}
