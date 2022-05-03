//
//  UINavigationController+Self.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 04.05.2022.
//

import UIKit

extension UINavigationController {
    open override var navigationController: UINavigationController? {
        self
    }
}
