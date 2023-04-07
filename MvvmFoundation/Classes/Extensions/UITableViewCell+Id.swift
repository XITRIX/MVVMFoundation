//
//  UITableViewCell+Id.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

extension UITableViewCell {
    @objc class var reusableId: String { "\(Self.self)" }
    @objc class var nib: UINib? { UINib(nibName: reusableId, bundle: Bundle(for: Self.self)) }
}
