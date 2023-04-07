//
//  SimpleViewModel.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import MvvmFoundation
import RxRelay
import UIKit

protocol SimpleViewModelProtocol: MvvmViewModel {
    var text: BehaviorRelay<String?> { get }
}

class SimpleViewModel: MvvmViewModel, SimpleViewModelProtocol {
    let text = BehaviorRelay<String?>(value: nil)

    init(text: String) {
        self.text.accept(text)
    }

    public required init() {}
}
