//
//  UITableView+Registration.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(type: T.Type, hasXib: Bool = true) {
        if hasXib {
            register(T.nib, forCellReuseIdentifier: T.reusableId)
        } else {
            register(T.self, forCellReuseIdentifier: T.reusableId)
        }
    }

    func dequeue<T: UITableViewCell>() -> T? {
        dequeueReusableCell(withIdentifier: T.reusableId) as? T
    }

    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reusableId, for: indexPath) as! T
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(type: T.Type, hasXib: Bool = true) {
        if hasXib {
            register(T.nib, forCellWithReuseIdentifier: T.reusableId)
        } else {
            register(T.self, forCellWithReuseIdentifier: T.reusableId)
        }
    }

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.reusableId, for: indexPath) as! T
    }
}

