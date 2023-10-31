//
//  ViewModel+Router.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

// MARK: - ViewController
public extension MvvmViewModelProtocol {
    static func resolveVC() -> UIViewController {
        Mvvm.shared.router.resolve(Self.init())
    }

    func resolveVC() -> UIViewController {
        Mvvm.shared.router.resolve(self)
    }
}

public extension MvvmViewModelWithProtocol {
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
    func resolveCell(from collectionView: UICollectionView, at indexPath: IndexPath, with supplementaryKind: String? = nil) -> UICollectionViewCell {
        Mvvm.shared.router.resolve(self, from: collectionView, at: indexPath, with: supplementaryKind)
    }
}
