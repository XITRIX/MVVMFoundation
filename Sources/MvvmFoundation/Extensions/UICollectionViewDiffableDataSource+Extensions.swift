//
//  UICollectionViewDiffableDataSource+Extensions.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

@available(iOS 13.0, *)
public extension UICollectionViewDiffableDataSource {
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>
}
