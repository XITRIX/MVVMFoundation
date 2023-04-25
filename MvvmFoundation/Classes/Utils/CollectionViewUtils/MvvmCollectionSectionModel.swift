//
//  MvvmCollectionSectionModel.swift
//  Kingfisher
//
//  Created by Даниил Виноградов on 25.04.2023.
//

import Foundation

public struct MvvmCollectionSectionModel: Hashable {
    public enum Style {
        case plain
        case grouped
        case insetGrouped
    }

    public let id: String

    public var header: String?
    public var footer: String?

    public var style: Style
    public var showsSeparators: Bool
    public var backgroundColor: UIColor? = .clear
    public var items: [MvvmViewModel]

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: MvvmCollectionSectionModel, rhs: MvvmCollectionSectionModel) -> Bool {
        lhs.id == rhs.id &&
            lhs.style == rhs.style &&
            lhs.showsSeparators == rhs.showsSeparators &&
            lhs.backgroundColor == rhs.backgroundColor &&
            lhs.header == rhs.header &&
            lhs.footer == rhs.footer
    }

    public init(id: String,
                header: String? = nil,
                footer: String? = nil,
                style: MvvmCollectionSectionModel.Style,
                showsSeparators: Bool,
                backgroundColor: UIColor? = .clear,
                items: [MvvmViewModel])
    {
        self.id = id
        self.header = header
        self.footer = footer
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items
    }
}
