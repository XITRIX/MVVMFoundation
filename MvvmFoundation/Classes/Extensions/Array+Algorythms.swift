//
//  Array+Algorythms.swift
//  ReManga
//
//  Created by Даниил Виноградов on 30.05.2023.
//

import Foundation

public extension Array where Element: Hashable {
    var unique: [Element] { removingDuplicates() }

    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
