//
//  MvvmSelectable.swift
//  ReManga
//
//  Created by Даниил Виноградов on 05.05.2023.
//

import Foundation

public protocol MvvmSelectableProtocol {
    var selectAction: (() -> Void)? { get }
}
