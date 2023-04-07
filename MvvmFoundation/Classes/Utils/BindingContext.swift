//
//  BindingContext.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation
import RxSwift

@resultBuilder
public enum BindingContext {
    public static func buildBlock() -> [Disposable] { [] }

    public static func buildBlock(_ components: Disposable...) -> [Disposable] {
        components
    }

    public static func buildArray(_ components: [[Disposable]]) -> [Disposable] {
        components.flatMap { $0 }
    }
}

public func bind(in disposeBag: DisposeBag, @BindingContext block: () -> [Disposable]) {
    block().forEach { $0.disposed(by: disposeBag) }
}
