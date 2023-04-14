//
//  DelegateObject.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

open class DelegateObject<Parent: AnyObject>: NSObject {
    public private(set) weak var parent: Parent!

    public init(parent: Parent) {
        self.parent = parent
    }
}
