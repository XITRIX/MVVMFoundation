//
//  MvvmCollectionViewDataSource.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit
import Combine

@available(iOS 14.0, *)
open class MvvmCollectionViewDataSource: UICollectionViewDiffableDataSource<MvvmCollectionSectionModel, MvvmCellViewModelWrapper<MvvmViewModel>> {
    private unowned let collectionView: UICollectionView

    public let modelSelected = PassthroughSubject<MvvmViewModel, Never>()

    public func deselectItems(animated: Bool) {
        for indexPath in collectionView.indexPathsForSelectedItems ?? [] {
            collectionView.deselectItem(at: indexPath, animated: animated)
        }
    }

    // Binding helper
    public func deselectItems() {
        deselectItems(animated: true)
    }

    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView

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

    // Helper for binding
    public func applyModels(_ sections: [MvvmCollectionSectionModel]) {
        applyModels(sections, animatingDifferences: true, completion: nil)
    }

    let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) {
        _, _, _ in
    }
}
