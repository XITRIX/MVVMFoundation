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
    @MainActor
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
    @MainActor
    func alert(title: String?, message: String? = nil, style: MvvmAlertStyle = .alert, actions: [MvvmAlertAction], sourceView: UIView? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style.alertStyle)

        if let sourceView {
            alert.popoverPresentationController?.sourceView = sourceView
            alert.popoverPresentationController?.sourceRect = sourceView.bounds
        }

        for action in actions {
            alert.addAction(action.alertAction)
        }

        Task {
            await navigationService?()?.navigate(to: alert, by: .present(wrapInNavigation: false))
        }
    }

    @MainActor
    func alertWithTimer(_ seconds: Double = 2, title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        navigationService?()?.navigate(to: alert, by: .present(wrapInNavigation: false))

        // change alert timer to 2 seconds, then dismiss
        let when = DispatchTime.now() + seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }
    }

    @MainActor
    func textInput(title: String?, message: String? = nil, placeholder: String?, defaultValue: String? = nil, type: UIKeyboardType = .default, secured: Bool = false, cancel: String, accept: String, result: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.text = defaultValue
            textField.keyboardType = type
            textField.isSecureTextEntry = secured
        }
        alert.addAction(.init(title: cancel, style: .cancel) { _ in
            result(nil)
        })
        alert.addAction(.init(title: accept, style: .default) { _ in
            result(alert.textFields?.first?.text ?? "")
        })

        navigationService?()?.navigate(to: alert, by: .present(wrapInNavigation: false))
    }

    @MainActor
    func textInputs(title: String?, message: String? = nil, textInputs: [MvvmTextInputModel], cancel: String, accept: String, result: @escaping ([String]?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        textInputs.forEach { model in
            alert.addTextField { textField in
                textField.placeholder = model.placeholder
                textField.text = model.defaultValue
                textField.keyboardType = model.type
                textField.isSecureTextEntry = model.secured
            }
        }
        alert.addAction(.init(title: cancel, style: .cancel) { _ in
            result(nil)
        })
        alert.addAction(.init(title: accept, style: .default) { _ in
            result(textInputs.enumerated().map { alert.textFields?[$0.offset].text ?? "" })
        })

        navigationService?()?.navigate(to: alert, by: .present(wrapInNavigation: false))
    }
}

public struct MvvmTextInputModel {
    let placeholder: String?
    let defaultValue: String?
    let type: UIKeyboardType
    let secured: Bool

    public init(placeholder: String?, defaultValue: String? = nil, type: UIKeyboardType = .default, secured: Bool = false) {
        self.placeholder = placeholder
        self.defaultValue = defaultValue
        self.type = type
        self.secured = secured
    }
}
