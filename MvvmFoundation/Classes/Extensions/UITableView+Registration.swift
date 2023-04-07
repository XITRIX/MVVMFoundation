//
//  UITableView+Registration.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(type: T.Type, hasXib: Bool = true) {
        if hasXib {
            register(T.nib, forCellReuseIdentifier: T.reusableId)
        } else {
            register(T.self, forCellReuseIdentifier: T.reusableId)
        }
    }
}
