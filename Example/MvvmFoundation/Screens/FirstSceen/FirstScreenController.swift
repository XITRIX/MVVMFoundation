//
//  FirstScreenController.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit
import MvvmFoundation

class FirstScreenController<VM: FirstScreenViewModelProtocol>: MvvmViewController<VM> {
    @IBOutlet var testLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(in: disposeBag) {
            testLabel.rx.text <- viewModel.text
        }
    }
}
