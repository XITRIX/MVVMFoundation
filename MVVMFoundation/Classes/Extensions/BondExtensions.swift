//
//  BondExtensions.swift
//  ReManga
//
//  Created by Даниил Виноградов on 05.11.2021.
//

import Bond
import Foundation
//import Kingfisher
import ReactiveKit
import UIKit

infix operator =>
public func =><S: SignalProtocol, B: BindableProtocol>(lhs: S, rhs: B) -> Disposable where S.Element == B.Element, S.Error == Never {
    lhs.bind(to: rhs)
}

public func =><S: SignalProtocol, B: BindableProtocol>(lhs: S, rhs: B) -> Disposable where B.Element: OptionalProtocol, B.Element.Wrapped == S.Element, S.Error == Never {
    lhs.bind(to: rhs)
}

infix operator <=>
public func <=><L: BindableProtocol, R: BindableProtocol & SignalProtocol>(lhs: L, rhs: R) -> Disposable where L: SignalProtocol, L.Error == Never, R.Element == L.Element, R.Error == L.Error {
    lhs.bidirectionalBind(to: rhs)
}

public extension UIButton {
    func bind(_ action: @escaping () -> ()) -> Disposable {
        self.reactive.tap.observeNext(with: action)
    }
}

public extension MutableChangesetContainerProtocol where Changeset: OrderedCollectionChangesetProtocol, Changeset.Collection: RangeReplaceableCollection {
    /// Insert elements `newElements` at index `i`.
    func append(_ newElements: [Collection.Element]) {
        descriptiveUpdate { collection -> [Operation] in
            let index = collection.endIndex
            collection.insert(contentsOf: newElements, at: index)
            let indices = (0 ..< newElements.count).map { collection.index(index, offsetBy: $0) }
            return indices.map { Operation.insert(collection[$0], at: $0) }
        }
    }
}

// extension UIImageView: BindableProtocol {
//    public func bind(signal: Signal<String?, Never>) -> Disposable {
//        return reactive.text.bind(signal: signal)
//    }
// }

//public extension ReactiveExtensions where Base: UIImageView {
//    var imageUrl: Bond<URL?> {
//        return bond {
//            $0.kf.setImage(with: $1)
//        }
//    }
//
//    var imagePath: Bond<String?> {
//        return bond {
//            guard let path = $1,
//                  let url = URL(string: path)
//            else { return }
//
//            $0.kf.setImage(with: url)
//        }
//    }
//}

public extension UIControl {
    func bindTap(_ function: @escaping () -> ()) -> Disposable {
        reactive.controlEvents(.touchUpInside).observeNext(with: function)
    }
}

public extension UIBarButtonItem {
    func bindTap(_ function: @escaping () -> ()) -> Disposable {
        reactive.tap.observeNext(with: function)
    }
}
