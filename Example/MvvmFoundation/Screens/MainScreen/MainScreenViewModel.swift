//
//  MainScreenViewModel.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import MvvmFoundation
import RxRelay
import RxSwift

protocol MainScreenViewModelProtocol: MvvmViewModelProtocol {
    var items: BehaviorRelay<[SimpleViewModel]> { get }
    func performAction(with model: SimpleViewModel)
}

class MainScreenViewModel: MvvmViewModel, MainScreenViewModelProtocol {
    let items = BehaviorRelay<[SimpleViewModel]>(value: [
        SimpleViewModel(text: "Text #1"),
        SimpleViewModel(text: "Text #2"),
        SimpleViewModel(text: "Text #3"),
        SimpleViewModel(text: "Text #4"),
        SimpleViewModel(text: "Text #5")
    ])

    required init() {
        super.init()
        title.accept("My main screen")
    }

    func performAction(with model: SimpleViewModel) {
//        navigate(to: MainScreenViewModel.self, by: .show)
        navigate(to: FirstScreenViewModelWith.self, with: model.text.value ?? "", by: .show)
    }
}
