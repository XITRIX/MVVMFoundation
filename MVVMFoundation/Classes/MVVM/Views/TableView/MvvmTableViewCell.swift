//
//  MvvmTableViewCell.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 28.03.2022.
//

import UIKit
import ReactiveKit

open class MvvmTableViewCell: UITableViewCell {
    public let reuseBag = DisposeBag()

    open override func awakeFromNib() {
        super.awakeFromNib()
        binding()
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag.dispose()
    }

    open func binding() {}
}
