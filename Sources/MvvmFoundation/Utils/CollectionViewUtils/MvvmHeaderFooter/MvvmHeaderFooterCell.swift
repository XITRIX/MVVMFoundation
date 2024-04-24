//
//  MvvmHeaderFooterCell.swift
//
//
//  Created by Daniil Vinogradov on 24/04/2024.
//

import UIKit

@available(iOS 14.0, *)
class MvvmHeaderFooterCell: UICollectionViewListCell {
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview == nil else { return }
        disposeBag = DisposeBag()
    }
}
