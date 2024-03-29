//
//  MvvmCollectionViewLayout.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

@available(iOS 14.0, *)
open class MvvmCollectionViewLayout: UICollectionViewCompositionalLayout {
    public init(_ dataSource: MvvmCollectionViewDataSource, headerMode: UICollectionLayoutListConfiguration.HeaderMode = .supplementary) {
        super.init(sectionProvider: { section, env in
            let sectionModel = dataSource.snapshot().sectionIdentifiers[section]

            var configuration = UICollectionLayoutListConfiguration(appearance: sectionModel.style.sectionStyle)
            if let backgroundColor = sectionModel.backgroundColor {
                configuration.backgroundColor = backgroundColor
            }
            #if !os(tvOS)
            configuration.showsSeparators = sectionModel.showsSeparators
            #endif
            configuration.headerMode = sectionModel.header.isNilOrEmpty ? .none : headerMode

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
        #if !os(tvOS)
        case .insetGrouped:
            return .insetGrouped
        case .sidebar:
            return .sidebar
        case .sidebarPlain:
            return .sidebarPlain
        #else
        default:
            return .grouped
        #endif
        }
    }
}
