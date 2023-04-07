//
//  Router.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
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
        storage[String(describing: VM.self)] = { viewModel in
            let vm = viewModel as! VM
            return VC(viewModel: vm)
        }
    }
}

// MARK: - Safe Resolve ViewController
public extension Router {
    func safeResolve<VM: MvvmViewModelProtocol>(_ viewModel: VM) -> (any MvvmViewControllerProtocol)? {
        storage[String(describing: VM.self)]?(viewModel) as? any MvvmViewControllerProtocol
    }
}

// MARK: - Resolve ViewController
public extension Router {
    func resolve<VM: MvvmViewModelProtocol>(_ viewModel: VM) -> any MvvmViewControllerProtocol {
        guard let vc = safeResolve(viewModel)
        else { fatalError("Could not resolve \(VM.self). Register it first") }
        return vc
    }
}

// MARK: - - TableViewCell

// MARK: - Register TableViewCell
public extension Router {
    func register<VM: MvvmViewModelProtocol, V: MvvmTableViewCellProtocol>(_ cell: V.Type)
        where V.ViewModel == VM
    {
        storage[String(describing: VM.self)] = { model in
            let (tableView, viewModel) = model as! (UITableView, VM)
            let getCell = { tableView.dequeueReusableCell(withIdentifier: V.reusableId) }
            var cell = getCell() as? V
            if cell == nil {
                tableView.register(type: V.self, hasXib: false)
                cell = getCell() as? V
            }
            cell?.setup(with: viewModel)
            return cell as Any
        }
    }
}

// MARK: - Safe Resolve TableViewCell
public extension Router {
    func safeResolve<VM: MvvmViewModelProtocol>(_ viewModel: VM, from tableView: UITableView) -> (any MvvmTableViewCellProtocol)? {
        storage[String(describing: type(of: viewModel))]?((tableView, viewModel)) as? any MvvmTableViewCellProtocol
    }
}

// MARK: - Resolve TableViewCell
public extension Router {
    func resolve<VM: MvvmViewModelProtocol>(_ viewModel: VM, from tableView: UITableView) -> any MvvmTableViewCellProtocol {
        guard let cell = safeResolve(viewModel, from: tableView)
        else { fatalError("Could not resolve \(VM.self). Register it first") }
        return cell
    }
}
