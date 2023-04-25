//
//  MvvmCollectionViewDataSource.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 25.04.2023.
//

import Foundation

@available(iOS 14.0, *)
open class MvvmCollectionViewDataSource: UICollectionViewDiffableDataSource<MvvmCollectionSectionModel, MvvmCellViewModelWrapper<MvvmViewModel>> {
    public init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            item.viewModel.resolveCell(from: collectionView, at: indexPath)
        }

        supplementaryViewProvider = { [unowned self] collectionView, _, indexPath in
            guard let dataSource = collectionView.dataSource as? MvvmCollectionViewDataSource
            else { return UICollectionReusableView() }

            let cell = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = dataSource.snapshot().sectionIdentifiers[indexPath.section].header
            cell.contentConfiguration = config
            return cell
        }
    }

    public func applyModels(_ sections: [MvvmCollectionSectionModel], animatingDifferences: Bool = true, completion: (() -> Void)? = nil) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items.map { .init(viewModel: $0) }, toSection: section)
        }
        apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
    }

    let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) {
        _, _, _ in
    }
}
