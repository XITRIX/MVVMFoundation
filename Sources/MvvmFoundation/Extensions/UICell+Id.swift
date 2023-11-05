//
//  UICell+Id.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
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
