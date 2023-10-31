//
//  MvvmCollectionView.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit
import Combine

public class MvvmCollectionView: UICollectionView {
    public var diffDataSource: MvvmCollectionViewDataSource!
    private let disposeBag = DisposeBag()

    public let sections = PassthroughRelay<[MvvmCollectionSectionModel]>()

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override func reloadData() {
        super.reloadData()
    }
}

extension MvvmCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = diffDataSource.snapshot().sectionIdentifiers[indexPath.section].items[indexPath.item]
        diffDataSource.modelSelected.send(item)
    }

    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        diffDataSource.snapshot().sectionIdentifiers[indexPath.section].items[indexPath.item].canBeSelected
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        diffDataSource.snapshot().sectionIdentifiers[indexPath.section].items[indexPath.item].canBeSelected
    }
}

private extension MvvmCollectionView {
    func setup() {
        diffDataSource = MvvmCollectionViewDataSource(collectionView: self)

        collectionViewLayout = MvvmCollectionViewLayout(diffDataSource)
        dataSource = diffDataSource
        delegate = self

        disposeBag.bind {
            sections.sink { [unowned self] sections in
                diffDataSource.applyModels(sections)
            }

            diffDataSource.modelSelected.sink { model in
                guard let selectable = model as? MvvmSelectableProtocol
                else { return }

                selectable.selectAction?()
            }
        }
    }
}
