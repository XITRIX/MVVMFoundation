//
//  BindingExtensions.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import RxBiBinding
import RxCocoa
import RxSwift
import SwiftUI

infix operator <->
public func <-> <E>(left: BehaviorRelay<E>, right: ControlProperty<E>) -> Disposable {
    right <-> left
}

infix operator <-
public func <- <E>(left: BehaviorRelay<E>, right: ControlProperty<E>) -> Disposable {
    right.bind(to: left)
}

public func <- <E, R: ObservableType>(left: BehaviorRelay<E>, right: R) -> Disposable
    where E == R.Element
{
    right.bind(to: left)
}

public func <- <L: ObserverType, R: ObservableType>(left: L, right: R) -> Disposable
    where R.Element == L.Element
{
    right.bind(to: left)
}

@available(iOS 13.0, *)
public func <- <L, R: ObservableType>(left: Binding<L>, right: R) -> Disposable
    where R.Element == L
{
    right.bind { value in
        left.wrappedValue = value
    }
}

public func <- <E>(left: BehaviorRelay<E?>, right: ControlProperty<E>) -> Disposable {
    right.bind(to: left)
}

public func <- <E, R: ObservableType>(left: BehaviorRelay<E?>, right: R) -> Disposable
    where E == R.Element
{
    right.bind(to: left)
}

public func <- <L: ObserverType, R: ObservableType>(left: L, right: R) -> Disposable
    where L.Element == R.Element?
{
    right.bind(to: left)
}

public func <- <L, R: ObservableType>(left: @escaping @MainActor (L) -> (), right: R) -> Disposable
    where R.Element == L
{
    right.bind { value in
        Task { await left(value) }
    }
}

public func <- <L, R: ObservableType>(left: @escaping (L?) -> (), right: R) -> Disposable
    where R.Element == L
{
    right.bind { value in
        left(value)
    }
}

@available(iOS 13.0, *)
public func <- <L, R: ObservableType>(left: Binding<L?>, right: R) -> Disposable
    where R.Element == L
{
    right.bind { value in
        left.wrappedValue = value
    }
}

public func <- <T>(left: @escaping (T) -> (), right: ControlEvent<T>) -> Disposable {
    right.bind { item in
        left(item)
    }
}
