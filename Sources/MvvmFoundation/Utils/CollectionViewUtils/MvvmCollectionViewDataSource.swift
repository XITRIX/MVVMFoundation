//
//  MvvmCollectionViewDataSource.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import Combine
import UIKit

@available(iOS 14.0, *)
open class MvvmCollectionViewDataSource: UICollectionViewDiffableDataSource<MvvmCollectionSectionModel, MvvmCellViewModelWrapper<MvvmViewModel>> {
    private unowned let collectionView: UICollectionView

    public let modelSelected = PassthroughSubject<MvvmViewModel, Never>()
    public let willReorderCells = PassthroughSubject<NSDiffableDataSourceTransaction<MvvmCollectionSectionModel, MvvmCellViewModelWrapper<MvvmViewModel>>, Never>()
    public let didReorderCells = PassthroughSubject<NSDiffableDataSourceTransaction<MvvmCollectionSectionModel, MvvmCellViewModelWrapper<MvvmViewModel>>, Never>()

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

        reorderingHandlers.canReorderItem = { $0.viewModel.canBeReordered }
        reorderingHandlers.willReorder = { [willReorderCells] in willReorderCells.send($0) }
        reorderingHandlers.didReorder = { [didReorderCells] in didReorderCells.send($0) }

        supplementaryViewProvider = { [unowned self] collectionView, elementKind, indexPath in
            guard let dataSource = collectionView.dataSource as? MvvmCollectionViewDataSource
            else { return UICollectionReusableView() }

            switch elementKind {
            case UICollectionView.elementKindSectionHeader:
                let cell = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
                var config = cell.defaultContentConfiguration()
                config.text = dataSource.snapshot().sectionIdentifiers[indexPath.section].header
                cell.contentConfiguration = config
                return cell
            case UICollectionView.elementKindSectionFooter:
                let cell = collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
                var config = cell.defaultContentConfiguration()
                config.text = dataSource.snapshot().sectionIdentifiers[indexPath.section].footer
                cell.contentConfiguration = config
                return cell
            default:
                fatalError("\(elementKind) in not registered and cannot be loaded")
            }
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

    let footerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionFooter) {
        _, _, _ in
    }
}
