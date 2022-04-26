//
//  UISearchBarExtensions.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 27.04.2022.
//

import Bond
import Foundation
import ReactiveKit

public extension ReactiveExtensions where Base: UISearchBar {
    var cancelTap: SafeSignal<()> {
        let selector = #selector(UISearchBarDelegate.searchBarCancelButtonClicked(_:))
        return delegate.signal(for: selector) { (subject: PassthroughSubject<Void, Never>, _: UISearchBar) in
            subject.send()
        }
    }
}
