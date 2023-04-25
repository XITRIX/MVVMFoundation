//
//  MvvmViewCellProtocol.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

public protocol MvvmViewCellProtocol: MvvmViewProtocol {
    func setup(with viewModel: ViewModel)
    func setViewModel(_ viewModel: ViewModel)
}

public protocol MvvmTableViewCellProtocol: MvvmViewCellProtocol, UITableViewCell {}
public protocol MvvmCollectionViewCellProtocol: MvvmViewCellProtocol, UICollectionViewCell {}
