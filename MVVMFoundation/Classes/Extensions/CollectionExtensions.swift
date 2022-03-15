//
//  StringExtensions.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 14.03.2022.
//

import Foundation

public extension Optional where Wrapped: Collection  {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
