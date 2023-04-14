//
//  UITableViewCell+Id.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

public extension UITableViewCell {
    @objc class var reusableId: String { "\(Self.self)" }
    @objc class var nib: UINib? { UINib(nibName: reusableId, bundle: Bundle(for: Self.self)) }
}

public extension UICollectionViewCell {
    @objc class var reusableId: String { "\(Self.self)" }
    @objc class var nib: UINib? { UINib(nibName: reusableId, bundle: Bundle(for: Self.self)) }
}
