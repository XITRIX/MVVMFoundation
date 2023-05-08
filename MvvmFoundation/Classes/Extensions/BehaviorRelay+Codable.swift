//
//  BehaviorRelay+Codable.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 08.05.2023.
//

import RxRelay

extension BehaviorRelay: Codable where Element: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(value: try container.decode(Element.self))
    }
}
