//
//  File.swift
//  
//
//  Created by Daniil Vinogradov on 04/04/2024.
//

import Foundation

public protocol MvvmReorderableProtocol {
    var canReorder: Bool { get }
}

@available(iOS 13.0, *)
public extension MvvmViewModel {
    var canBeReordered: Bool {
        (self as? MvvmReorderableProtocol)?.canReorder ?? false
    }
}
