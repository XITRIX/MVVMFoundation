//
//  Binding.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 10.05.2023.
//

import RxRelay

@propertyWrapper
public struct Binding<Value> {
    public let projectedValue: BehaviorRelay<Value>

    public var wrappedValue: Value {
        get { projectedValue.value }
        set { projectedValue.accept(newValue) }
    }

    public init(wrappedValue: Value) {
        self.projectedValue = .init(value: wrappedValue)
    }
}
