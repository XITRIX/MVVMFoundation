//
//  SimpleCell.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import MvvmFoundation
import UIKit

class SimpleCell<VM: SimpleViewModelProtocol>: MvvmTableViewCell<VM> {
    @IBOutlet private var simpleTextLabel: UILabel!

    override func setup(with viewModel: VM) {
        bind(in: disposeBag) {
            simpleTextLabel.rx.text <- viewModel.text
        }
    }
}
