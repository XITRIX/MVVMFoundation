//
//  UICollectionView+Rx.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 23.04.2023.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UICollectionView {
    public var indexPathsForSelectedItems: ControlProperty<[IndexPath]> {
        let source: Observable<[IndexPath]> = Observable.deferred { [weak collectionView = self.base] in
            let selectedItems = collectionView?.indexPathsForSelectedItems

            guard let collectionView else { return Observable.empty().startWith(selectedItems ?? []) }

            let selectedItemsChanged = Observable.of(collectionView.rx.itemSelected, collectionView.rx.itemDeselected)
                .merge()
                .map { _ in base.indexPathsForSelectedItems ?? [] }

            return selectedItemsChanged
                .startWith(selectedItems ?? [])
        }

        let bindingObserver = Binder(self.base) { (collectionView, items: [IndexPath]) in
            collectionView.indexPathsForSelectedItems?.forEach { collectionView.deselectItem(at: $0, animated: true) }
            items.forEach { collectionView.selectItem(at: $0, animated: true, scrollPosition: []) }
        }

        return ControlProperty(values: source, valueSink: bindingObserver)
    }
}
