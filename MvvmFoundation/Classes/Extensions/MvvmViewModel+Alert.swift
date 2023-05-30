//
//  MvvmViewModel+Alert.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 30.05.2023.
//

import UIKit

public struct MvvmAlertAction {
    public var title: String
    public var style: UIAlertAction.Style
    public var action: (() -> Void)?

    public init(title: String, style: UIAlertAction.Style, action: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.action = action
    }
}

extension MvvmAlertAction {
    var alertAction: UIAlertAction {
        .init(title: title, style: style) { _ in action?() }
    }
}

public extension MvvmViewModelProtocol {
    func alert(title: String?, message: String?, actions: [MvvmAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action.alertAction)
        }
        navigationService.present(alert, animated: true)
    }
}
