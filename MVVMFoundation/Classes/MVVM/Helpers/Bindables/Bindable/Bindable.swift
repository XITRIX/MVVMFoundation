//
//  Bindable.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 13.03.2022.
//

import Bond
import ReactiveKit

@propertyWrapper public struct Bindable<Value> {
    private let value: Observable<Value>

    public var wrappedValue: Value {
        get { value.value }
        set { value.value = newValue }
    }

    public var projectedValue: Observable<Value> { value }

    public init(wrappedValue value: Value) {
        self.value = Observable<Value>(value)
    }
}
