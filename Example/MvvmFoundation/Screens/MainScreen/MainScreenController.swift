//
//  MainScreenController.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import MvvmFoundation
import UIKit

class MainScreenController<VM: MainScreenViewModelProtocol>: MvvmViewController<VM> {
    @IBOutlet private var tableView: UITableView!
    private lazy var dataSource = UITableViewDiffableDataSource<Int, SimpleViewModel>(tableView: tableView) { tableView, _, itemIdentifier in
        itemIdentifier.resolveCell(from: tableView)
    }

    deinit {
        print("DEINIT!!!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource

        bind(in: disposeBag) {
            viewModel.items.bind { [unowned self] models in
                applyModels(models)
            }

            tableView.rx.itemSelected.bind { [unowned self] indexPath in
                let item = dataSource.snapshot().itemIdentifiers(inSection: indexPath.section)[indexPath.row]
                viewModel.performAction(with: item)
            }
        }
    }

    func applyModels(_ models: [SimpleViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SimpleViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models)
        dataSource.apply(snapshot)
    }

    private lazy var delegates = Delegates(parent: self)
}

extension MainScreenController {
    class Delegates: DelegateObject<MainScreenController> {}
}
