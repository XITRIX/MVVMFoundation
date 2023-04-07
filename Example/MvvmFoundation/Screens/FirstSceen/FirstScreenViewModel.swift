//
//  FirstScreenViewModel.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import MvvmFoundation
import RxSwift
import RxRelay

protocol FirstScreenViewModelProtocol: MvvmViewModelProtocol {
    var text: BehaviorRelay<String?> { get }
}

class FirstScreenViewModel: MvvmViewModel, FirstScreenViewModelProtocol {
    let text = BehaviorRelay<String?>(value: "TESTING TEST TEXT")
}

class FirstScreenViewModelWith: MvvmViewModelWith<String>, FirstScreenViewModelProtocol {
    let text = BehaviorRelay<String?>(value: "Loading...")
    @Injected var api: ApiProtocol

    required init() {
        super.init()
        title.accept("Password reveal")
    }

    override func prepare(with model: String) {
        Task {
            let message = try await api.getSuperSecretMessage(model)
            text.accept(message)
        }
    }
}
