//
//  BindContext.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 14.03.2022.
//

import ReactiveKit

@resultBuilder
public enum BinderBuilder {
    public static func buildBlock() -> [Disposable] { [] }

    public static func buildBlock(_ components: Disposable...) -> [Disposable] {
        components
    }

    public static func buildArray(_ components: [[Disposable]]) -> [Disposable] {
        components.flatMap { $0 }
    }
}

public extension NSObject {
    func bind(in disposeBag: DisposeBag, @BinderBuilder block: () -> [Disposable]) {
        block().forEach { $0.dispose(in: disposeBag) }
    }
}
