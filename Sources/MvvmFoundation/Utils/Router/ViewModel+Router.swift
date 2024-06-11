//
//  ViewModel+Router.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

// MARK: - ViewController
public extension MvvmViewModelProtocol {
    @MainActor
    static func resolveVC() -> UIViewController {
        Mvvm.shared.router.resolve(Self.init())
    }

    @MainActor
    func resolveVC() -> UIViewController {
        Mvvm.shared.router.resolve(self)
    }
}

public extension MvvmViewModelWithProtocol {
    @MainActor
    static func resolveVC(with model: Model) -> UIViewController {
        let vm = Self.init(with: model)
        return Mvvm.shared.router.resolve(vm)
    }
}

//// MARK: - TableViewCell
//public extension MvvmViewModelProtocol {
//    func resolveCell(from tableView: UITableView) -> UITableViewCell {
//        Mvvm.shared.router.resolve(self, from: tableView)
//    }
//}

// MARK: - CollectionViewCell
public extension MvvmViewModelProtocol {
    @MainActor
    func resolveCell(from collectionView: UICollectionView, at indexPath: IndexPath, with supplementaryKind: String? = nil) -> UICollectionViewCell {
        Mvvm.shared.router.resolve(self, from: collectionView, at: indexPath, with: supplementaryKind)
    }
}
