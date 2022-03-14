//
//  Bindable+Extensions.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 14.03.2022.
//

import Foundation

extension Bindable: Equatable where Value: Equatable {
    public static func == (lhs: Bindable<Value>, rhs: Bindable<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

extension Bindable: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

extension Bindable: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(wrappedValue: try container.decode(Value.self))
    }
}

extension Bindable: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension Bindable: OptionalCodingWrapper where Value: ExpressibleByNilLiteral { }
