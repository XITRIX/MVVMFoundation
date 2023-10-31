//
//  DelegateObject.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation

open class DelegateObject<Parent: AnyObject>: NSObject {
    public private(set) weak var parent: Parent!

    public init(parent: Parent) {
        self.parent = parent
    }
}
