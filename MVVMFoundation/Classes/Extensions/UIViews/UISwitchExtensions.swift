//
//  UISwitchExtensions.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 23.04.2022.
//

import Bond
import ReactiveKit
import UIKit

public extension ReactiveExtensions where Base: UISwitch {
    var onTintColor: Bond<UIColor?> {
        return bond { $0.onTintColor = $1 }
    }
}
