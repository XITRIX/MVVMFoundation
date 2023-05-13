//
//  MvvmCollectionViewLayout.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 25.04.2023.
//

import UIKit

@available(iOS 14.0, *)
open class MvvmCollectionViewLayout: UICollectionViewCompositionalLayout {
    public init(_ dataSource: MvvmCollectionViewDataSource) {
        super.init(sectionProvider: { section, env in
            let sectionModel = dataSource.snapshot().sectionIdentifiers[section]

            var configuration = UICollectionLayoutListConfiguration(appearance: sectionModel.style.sectionStyle)
            if let backgroundColor = sectionModel.backgroundColor {
                configuration.backgroundColor = backgroundColor
            }
            configuration.showsSeparators = sectionModel.showsSeparators
            configuration.headerMode = sectionModel.header.isNilOrEmpty ? .none : .supplementary
            configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
                dataSource.trailingSwipeActionsConfigurationProvider?(indexPath) ?? .init(actions: [])
            }

            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: env)
            return section
        })
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 14.0, *)
public extension MvvmCollectionSectionModel.Style {
    var sectionStyle: UICollectionLayoutListConfiguration.Appearance {
        switch self {
        case .plain:
            return .plain
        case .grouped:
            return .grouped
        case .insetGrouped:
            return .insetGrouped
        }
    }
}
