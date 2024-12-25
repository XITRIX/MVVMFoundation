//
//  KeyboardHandler.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 31/10/2023.
//

import UIKit

@MainActor
public class KeyboardHandler {
    public init(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
        registerForKeyboardNotifications()
    }

    deinit {
        unregisterKeyboardNotifications()
    }

    private weak var scrollView: UIScrollView?
    private var lastExtraContentOffset: Double = 0
}

private extension KeyboardHandler {
    func registerForKeyboardNotifications() {
#if !os(tvOS)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
#endif
    }

    nonisolated
    func unregisterKeyboardNotifications() {
#if !os(tvOS)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
#endif
    }

    @objc func onKeyboardAppear(_ notification: NSNotification) {
#if !os(tvOS)
        guard let scrollView else { return }
        let info = notification.userInfo!
        let oldRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let rect = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let animationCurve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt

        // Convert the animation curve constant to animation options.
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurve << 16)

        let scrollFrame = CGRect(origin: scrollView.superview?.convert(scrollView.frame.origin, to: scrollView.window) ?? .zero, size: scrollView.frame.size)

        let intersection = scrollFrame.intersection(rect)
        let inset = max(0, intersection.height - scrollView.safeAreaInsets.bottom)
        scrollView.contentInset.bottom = inset
        scrollView.verticalScrollIndicatorInsets.bottom = inset
#endif
    }
}
