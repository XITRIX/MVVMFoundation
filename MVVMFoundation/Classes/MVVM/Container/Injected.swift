//
//  Injected.swift
//  Countries
//
//  Created by Даниил Виноградов on 18.06.2022.
//

@propertyWrapper
public struct Injected<T: Any> {
    public var wrappedValue: T {
        get {
            MVVM.shared.container.resolve() as T
        }
    }

    public init() {}
}
