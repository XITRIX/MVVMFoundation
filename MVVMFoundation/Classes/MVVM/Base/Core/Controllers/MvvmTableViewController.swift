//
//  MvvmTableViewController.swift
//  ReManga
//
//  Created by Даниил Виноградов on 04.11.2021.
//

import UIKit

open class MvvmTableViewController<ViewModel: MvvmViewModelProtocol>: UITableViewController, MvvmViewControllerProtocol {
    public var _viewModel: MvvmViewModelProtocol!
    public var viewModel: ViewModel { _viewModel as! ViewModel }

    override open func viewDidLoad() {
        super.viewDidLoad()
        viewModel.title.observeNext(with: { [unowned self] in title = $0 }).dispose(in: bag)
    }
}
