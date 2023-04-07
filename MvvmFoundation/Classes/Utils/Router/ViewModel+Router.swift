//
//  ViewModel+Router.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

// MARK: - ViewController
public extension MvvmViewModelProtocol {
    static func resolveVC() -> UIViewController {
        Mvvm.shared.router.resolve(Self.init())
    }
}

public extension MvvmViewModelWithProtocol {
    static func resolveVC(with model: Model) -> UIViewController {
        let vm = Self.init()
        vm.prepare(with: model)
        return Mvvm.shared.router.resolve(vm)
    }
}

// MARK: - TableViewCell
public extension MvvmViewModelProtocol {
    func resolveCell(from tableView: UITableView) -> UITableViewCell {
        Mvvm.shared.router.resolve(self, from: tableView)
    }
}
