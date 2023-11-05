//
//  UIView+UIViewController.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

public extension UIView {
    var viewController: UIViewController? {
        var nextResponder = next

        while nextResponder != nil {
            if let nextResponder = nextResponder as? UIViewController {
                return nextResponder
            }

            nextResponder = nextResponder?.next
        }

        return nil
    }
}
