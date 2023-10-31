//
//  MvvmViewCellProtocol.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import SwiftUI

public protocol MvvmViewCellProtocol: MvvmViewProtocol {}

public protocol MvvmViewUIKitCellProtocol: MvvmViewProtocol {
    func setup(with viewModel: ViewModel)
    func setViewModel(_ viewModel: ViewModel)
}

public protocol MvvmTableViewCellProtocol: MvvmViewUIKitCellProtocol, UITableViewCell {}
public protocol MvvmCollectionViewCellProtocol: MvvmViewUIKitCellProtocol, UICollectionViewCell {}

public protocol MvvmSwiftUICellProtocol: MvvmViewCellProtocol, View {
    associatedtype CellType: UICollectionViewCell
    nonisolated static var registration: UICollectionView.CellRegistration<CellType, ViewModel> { get }
}
