//
//  MvvmAssociatedObjectHolder.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 24.04.2023.
//

import Foundation

public protocol MvvmAssociatedObjectHolderProtocol: AnyObject {
    func applyAssociatedObject<T>(_ object: T?) -> Self
    func getAssociatedObject<T>() -> T?
}

private var MvvmAssociatedObjectHolderAssociateKey = "MvvmAssociatedObjectHolderAssociateKey"
extension MvvmAssociatedObjectHolderProtocol {
    var associatedObjects: [String: Any] {
        get {
            objc_getAssociatedObject(self, &MvvmAssociatedObjectHolderAssociateKey) as? [String: Any] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &MvvmAssociatedObjectHolderAssociateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    @discardableResult
    public func applyAssociatedObject<T>(_ object: T?) -> Self {
        associatedObjects[String(describing: T.self)] = object
        return self
    }

    public func getAssociatedObject<T>() -> T? {
        associatedObjects[String(describing: T.self)] as? T
    }
}
