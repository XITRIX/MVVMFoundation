//
//  MvvmAssociatedObjectHolderProtocol.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Foundation

public protocol MvvmAssociatedObjectHolderProtocol: AnyObject {
    func applyAssociatedObject<T>(_ object: T?) -> Self
    func getAssociatedObject<T>() -> T?
}

private enum MvvmAssociatedObjectHolderKeys {
    nonisolated(unsafe) static var associateKey: Void?
}

extension MvvmAssociatedObjectHolderProtocol {

    var associatedObjects: [String: Any] {
        get {
            objc_getAssociatedObject(self, &MvvmAssociatedObjectHolderKeys.associateKey) as? [String: Any] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &MvvmAssociatedObjectHolderKeys.associateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
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
