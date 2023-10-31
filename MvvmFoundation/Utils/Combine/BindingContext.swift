//
//  BindingContext.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation
import Combine

public class DisposeBag {
    private var cancellables: [AnyCancellable] = []

    fileprivate func append(_ cancellable: AnyCancellable) {
        cancellables.append(cancellable)
    }
}

public extension DisposeBag {
    func bind(@BindingContext block: () -> [AnyCancellable]) {
        block().forEach { append($0) }
    }
}

@resultBuilder
public enum BindingContext {
    public static func buildBlock() -> [AnyCancellable] { [] }

    public static func buildBlock(_ components: AnyCancellable...) -> [AnyCancellable] {
        components
    }

    public static func buildArray(_ components: [[AnyCancellable]]) -> [AnyCancellable] {
        components.flatMap { $0 }
    }

    public static func buildEither(first component: [AnyCancellable]) -> [AnyCancellable] {
        component
    }

    public static func buildEither(second component: [AnyCancellable]) -> [AnyCancellable] {
        component
    }
}

public func bind(in disposeBag: inout [AnyCancellable], @BindingContext block: () -> [AnyCancellable]) {
    block().forEach { $0.store(in: &disposeBag) }
}

public func bind(in disposeBag: DisposeBag, @BindingContext block: () -> [AnyCancellable]) {
    block().forEach { disposeBag.append($0) }
}
