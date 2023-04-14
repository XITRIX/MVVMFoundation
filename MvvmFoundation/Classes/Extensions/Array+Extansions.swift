//
//  Array+Extansions.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 12.04.2023.
//

import Foundation

public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
