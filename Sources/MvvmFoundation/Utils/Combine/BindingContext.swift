//
//  BindingContext.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public class DisposeBag: Codable {
    private var cancellables: [AnyCancellable] = []

    fileprivate func append(_ cancellable: AnyCancellable) {
        cancellables.append(cancellable)
    }

    public init() {}

    // Confirm to Codable to allow it inside of Codable objects
    public required init(from decoder: any Decoder) throws {}
    public func encode(to encoder: any Encoder) throws {}
}

@available(iOS 13.0, *)
public extension DisposeBag {
    func bind(@BindingContext block: () -> [AnyCancellable]) {
        block().forEach { append($0) }
    }
}

@available(iOS 13.0, *)
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

    public static func buildOptional(_ component: [AnyCancellable]?) -> [AnyCancellable] {
        component ?? []
    }
}

@available(iOS 13.0, *)
public func bind(in disposeBag: inout [AnyCancellable], @BindingContext block: () -> [AnyCancellable]) {
    block().forEach { $0.store(in: &disposeBag) }
}

@available(iOS 13.0, *)
public func bind(in disposeBag: DisposeBag, @BindingContext block: () -> [AnyCancellable]) {
    block().forEach { disposeBag.append($0) }
}
