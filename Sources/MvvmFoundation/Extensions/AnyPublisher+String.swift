//
//  AnyPublisher+String.swift
//  
//
//  Created by Daniil Vinogradov on 24/04/2024.
//

import Combine

public extension AnyPublisher where Output == String, Failure == Never {
    init?(_ string: String?) {
        guard let string else { return nil }
        self = Just(string).eraseToAnyPublisher()
    }
}
