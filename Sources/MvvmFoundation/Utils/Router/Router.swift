//
//  Router.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

public class Router {
    private var storage = [String: (Any?) -> Any]()
}

// MARK: - - ViewController

// MARK: - Register ViewController
public extension Router {
    func register<VM: MvvmViewModelProtocol, VC: MvvmViewControllerProtocol>(_ controller: VC.Type)
        where VC.ViewModel == VM
    {
        storage[String(describing: VM.self)] = { @MainActor viewModel in
            let vm = viewModel as! VM
            return VC(viewModel: vm)
        }
    }
}

// MARK: - Safe Resolve ViewController
public extension Router {
    @MainActor
    func safeResolve<VM: MvvmViewModelProtocol>(_ viewModel: VM) -> (any MvvmViewControllerProtocol)? {
        storage[String(describing: VM.self)]?(viewModel) as? any MvvmViewControllerProtocol
    }
}

// MARK: - Resolve ViewController
public extension Router {
    @MainActor
    func resolve<VM: MvvmViewModelProtocol>(_ viewModel: VM) -> any MvvmViewControllerProtocol {
        guard let vc = safeResolve(viewModel)
        else { fatalError("Could not resolve \(VM.self). Register it first") }
        return vc
    }
}

//// MARK: - - TableViewCell
//
//// MARK: - Register TableViewCell
//public extension Router {
//    func register<VM: MvvmViewModelProtocol, V: MvvmTableViewCellProtocol>(_ cell: V.Type)
//        where V.ViewModel == VM
//    {
//        storage[String(describing: VM.self)] = { model in
//            let (tableView, viewModel) = model as! (UITableView, VM)
//            let getCell = { tableView.dequeueReusableCell(withIdentifier: V.reusableId) }
//            var cell = getCell() as? V
//            if cell == nil {
//                tableView.register(type: V.self, hasXib: false)
//                cell = getCell() as? V
//            }
//            if let cell {
//                cell.setViewModel(viewModel)
//                cell.setup(with: viewModel)
//                if let navService = cell.viewController {
//                    viewModel.setNavigationService(navService)
//                }
//            }
//            return cell as Any
//        }
//    }
//}
//
//// MARK: - Safe Resolve TableViewCell
//public extension Router {
//    func safeResolve<VM: MvvmViewModelProtocol>(_ viewModel: VM, from tableView: UITableView) -> (any MvvmTableViewCellProtocol)? {
//        storage[String(describing: type(of: viewModel))]?((tableView, viewModel)) as? any MvvmTableViewCellProtocol
//    }
//}
//
//// MARK: - Resolve TableViewCell
//public extension Router {
//    func resolve<VM: MvvmViewModelProtocol>(_ viewModel: VM, from tableView: UITableView) -> any MvvmTableViewCellProtocol {
//        guard let cell = safeResolve(viewModel, from: tableView)
//        else { fatalError("Could not resolve \(VM.self). Register it first") }
//        return cell
//    }
//}

// MARK: - - CollectionViewCell

// MARK: - Register CollectionViewCell
public extension Router {
    func register<VM: MvvmViewModelProtocol, V: MvvmCollectionViewCellProtocol>(_ cell: V.Type)
        where V.ViewModel == VM
    {
        storage[String(describing: VM.self)] = { model in
            let (collectionView, viewModel, indexPath, supplementaryKind) = model as! (UICollectionView, VM, IndexPath, String?)

            if let supplementaryKind {
                collectionView.register(V.self, forSupplementaryViewOfKind: supplementaryKind, withReuseIdentifier: V.reusableId)
            } else {
                collectionView.register(type: V.self, hasXib: false)
            }

            let getCell = {
                if let supplementaryKind {
                    return collectionView.dequeueReusableSupplementaryView(ofKind: supplementaryKind, withReuseIdentifier: V.reusableId, for: indexPath)
                } else {
                    return collectionView.dequeueReusableCell(withReuseIdentifier: V.reusableId, for: indexPath)
                }
            }
            let cell = getCell() as? V
            if let cell {
                cell.setViewModel(viewModel)
                cell.setup(with: viewModel)
                viewModel.setNavigationService { cell.viewController }
            }
            return cell as Any
        }
    }

    @available(iOS 14.0, *)
    func register<VM: MvvmViewModelProtocol, V: MvvmSwiftUICellProtocol>(_ cell: V.Type)
        where V.ViewModel == VM
    {
        _ = V.registration // Initialise registration
        storage[String(describing: VM.self)] = { @MainActor model in
            let (collectionView, viewModel, indexPath, supplementaryKind) = model as! (UICollectionView, VM, IndexPath, String?)

            let getCell = {
//                if let supplementaryKind {
//                    return collectionView.dequeueConfiguredReusableSupplementary(using: V.registration, for: indexPath)
//                } else {
                return collectionView.dequeueConfiguredReusableCell(using: V.registration, for: indexPath, item: viewModel)
//                }
            }
            let cell = getCell()
            return cell as Any
        }
    }
}

// MARK: - Safe Resolve CollectionViewCell
public extension Router {
    @MainActor
    func safeResolve<VM: MvvmViewModelProtocol>(_ viewModel: VM, from tableView: UICollectionView, at indexPath: IndexPath, with supplementaryKind: String? = nil) -> UICollectionViewCell? {
        storage[String(describing: type(of: viewModel))]?((tableView, viewModel, indexPath, supplementaryKind)) as? UICollectionViewCell
    }
}

// MARK: - Resolve CollectionViewCell
public extension Router {
    @MainActor
    func resolve<VM: MvvmViewModelProtocol>(_ viewModel: VM, from tableView: UICollectionView, at indexPath: IndexPath, with supplementaryKind: String? = nil) -> UICollectionViewCell {
        guard let cell = safeResolve(viewModel, from: tableView, at: indexPath, with: supplementaryKind)
        else { fatalError("Could not resolve \(String(describing: type(of: viewModel))). Register it first") }
        return cell
    }
}
