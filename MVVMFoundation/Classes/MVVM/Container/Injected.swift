//
//  Injected.swift
//  Countries
//
//  Created by Даниил Виноградов on 18.06.2022.
//

import MVVMFoundation

@propertyWrapper
struct Injected<T: Any> {
    var wrappedValue: T {
        get {
            MVVM.shared.container.resolve() as T
        }
    }
}
