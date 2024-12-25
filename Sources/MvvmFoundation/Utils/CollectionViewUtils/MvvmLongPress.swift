//
//  MvvmLongPress.swift
//  
//
//  Created by Даниил Виноградов on 07.04.2024.
//

import Foundation

public protocol MvvmLongPressProtocol {
    var longPressAction: (@MainActor () -> Void)? { get }
}

@available(iOS 13.0, *)
public extension MvvmViewModel {
    var canBeLongPressed: Bool {
        (self as? MvvmLongPressProtocol)?.longPressAction != nil
    }
}
