//
//  Array+Algorythms.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import Foundation

public extension Array where Element: Hashable {
    var unique: [Element] { removingDuplicates() }

    func removingDuplicates() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
