//
//  BindableArray.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 13.03.2022.
//

import Bond
import ReactiveKit
import Bond

@propertyWrapper public struct BindableArray<Value> {
    private let value: MutableObservableArray<Value>

    public var wrappedValue: [Value] {
        get { value.collection }
        set { value.replace(with: newValue) }
    }

    public var projectedValue: MutableObservableArray<Value> { value }

    public init(wrappedValue value: [Value]) {
        self.value = MutableObservableArray<Value>(value)
    }
}
