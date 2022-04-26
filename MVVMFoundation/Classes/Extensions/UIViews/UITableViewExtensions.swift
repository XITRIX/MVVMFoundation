//
//  UITableViewExtensions.swift
//  MVVMFoundation
//
//  Created by Даниил Виноградов on 26.04.2022.
//

import Bond
import Foundation
import ReactiveKit

public extension ReactiveExtensions where Base: UITableView {
    private var indexPathsForSelectedRowsOnSelected: SafeSignal<[IndexPath]> {
        return delegate.signal(for: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))) { (subject: PassthroughSubject<[IndexPath], Never>, _: UITableView, _: IndexPath) in
            subject.send(base.indexPathsForSelectedRows ?? [])
        }
    }

    private var indexPathsForSelectedRowsOnDeselected: SafeSignal<[IndexPath]> {
        return delegate.signal(for: #selector(UITableViewDelegate.tableView(_:didDeselectRowAt:))) { (subject: PassthroughSubject<[IndexPath], Never>, _: UITableView, _: IndexPath) in
            subject.send(base.indexPathsForSelectedRows ?? [])
        }
    }

    var indexPathsForSelectedRows: SafeSignal<[IndexPath]> {
        combineLatest(indexPathsForSelectedRowsOnSelected, indexPathsForSelectedRowsOnDeselected).map { _ in
            return base.indexPathsForSelectedRows ?? []
        }
    }
}
