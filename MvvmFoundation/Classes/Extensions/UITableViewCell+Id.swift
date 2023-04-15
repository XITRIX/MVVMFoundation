//
//  UITableViewCell+Id.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

extension UITableViewCell {
    @objc class open var reusableId: String { "\(Self.self)" }
    @objc class open var nib: UINib? { UINib(nibName: reusableId, bundle: Bundle(for: Self.self)) }
}

extension UICollectionViewCell {
    @objc class open var reusableId: String { "\(Self.self)" }
    @objc class open var nib: UINib? { UINib(nibName: reusableId, bundle: Bundle(for: Self.self)) }
}
