//
//  MvvmCollectionSectionModel.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

public struct MvvmCollectionSectionModel: Hashable {
    public enum Style {
        case plain
        case grouped
        case insetGrouped
        case sidebar
        case sidebarPlain
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
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
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

    public init(id: String,
                header: String? = nil,
                footer: String? = nil,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                @ViewModelsContext items: () -> [MvvmViewModel])
    {
        self.id = id
        self.header = header
        self.footer = footer
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items()
    }
}

@resultBuilder
@MainActor
public enum ViewModelsContext {
    public static func buildBlock() -> [MvvmViewModel] { [] }

    public static func buildBlock(_ components: [MvvmViewModel]...) -> [MvvmViewModel] {
        components.flatMap { $0 }
    }

    public static func buildBlock(_ components: [[MvvmViewModel]]) -> [MvvmViewModel] {
        components.flatMap { $0 }
    }

    public static func buildBlock(_ components: [MvvmViewModel]) -> [MvvmViewModel] {
        components
    }

    public static func buildOptional(_ component: [MvvmViewModel]?) -> [MvvmViewModel] {
        component ?? []
    }

    public static func buildExpression(_ expression: MvvmViewModel) -> [MvvmViewModel] {
        [expression]
    }
}
