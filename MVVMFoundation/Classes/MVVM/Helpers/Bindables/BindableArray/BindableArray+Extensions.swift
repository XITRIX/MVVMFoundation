//
//  BindableArray+Extensions.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 14.03.2022.
//

import Foundation

extension BindableArray: Equatable where Value: Equatable {
    public static func == (lhs: BindableArray<Value>, rhs: BindableArray<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

extension BindableArray: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

extension BindableArray: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(wrappedValue: try container.decode([Value].self))
    }
}

extension BindableArray: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

