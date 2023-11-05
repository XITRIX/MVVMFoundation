//
//  MvvmViewModel+Alert.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 01/11/2023.
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

public enum MvvmAlertStyle {
    case actionSheet
    case alert
}

private extension MvvmAlertAction {
    var alertAction: UIAlertAction {
        .init(title: title, style: style) { _ in action?() }
    }
}

private extension MvvmAlertStyle {
    var alertStyle: UIAlertController.Style {
        switch self {
        case .actionSheet:
            return .actionSheet
        case .alert:
            return .alert
        }
    }
}

public extension MvvmViewModelProtocol {
    func alert(title: String?, message: String?, style: MvvmAlertStyle = .alert, actions: [MvvmAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style.alertStyle)
        for action in actions {
            alert.addAction(action.alertAction)
        }
        navigationService?()?.present(alert, animated: true)
    }

    func alertWithTimer(_ timer: Double = 2, title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        navigationService?()?.present(alert, animated: true)
        // change alert timer to 2 seconds, then dismiss
        let when = DispatchTime.now() + timer
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
