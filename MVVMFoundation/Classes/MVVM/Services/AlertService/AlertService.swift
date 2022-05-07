//
//  AlertService.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 08.05.2022.
//

import Foundation

public struct AlertModel {
    let title: String?
    let message: String?
    let action: (title: String, action: (() -> ())?)

    public init(title: String? = nil, message: String? = nil, action: (title: String, action: (() -> ())?)) {
        self.title = title
        self.message = message
        self.action = action
    }
}

public protocol AlertService {
    func showAlert(_ alert: AlertModel, in model: MvvmViewModel)
}

class IOSAlertService: AlertService {
    func showAlert(_ alert: AlertModel, in model: MvvmViewModel) {
        let vc = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: alert.action.title, style: .cancel, handler: { _ in
            alert.action.action?()
        }))
        model.attachedView.present(vc, animated: true)
    }
}
