//
//  MvvmCollectionSectionModel.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit
import Combine

@available(iOS 13.0, *)
public struct MvvmCollectionSectionModel: Hashable {
    public enum Style {
        case plain
        case grouped
        case insetGrouped
        case sidebar
        case sidebarPlain
        case platformPlain
    }

    public let id: String

    public var header: AnyPublisher<String, Never>?
    public var headerTopPadding: CGFloat?
    public var footer: AnyPublisher<String, Never>?

    public var style: Style
    public var showsSeparators: Bool
    public var backgroundColor: UIColor? = nil
    public var items: [MvvmViewModel]

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: MvvmCollectionSectionModel, rhs: MvvmCollectionSectionModel) -> Bool {
        lhs.id == rhs.id &&
            lhs.style == rhs.style &&
            lhs.showsSeparators == rhs.showsSeparators &&
            lhs.backgroundColor == rhs.backgroundColor
    }

    public init(id: String,
                header: String? = nil,
                headerTopPadding: CGFloat? = nil,
                footer: String? = nil,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                items: [MvvmViewModel])
    {
        self.id = id
        self.header = .init(header)
        self.headerTopPadding = headerTopPadding
        self.footer = .init(footer)
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items
    }

    public init(id: String,
                header: String? = nil,
                headerTopPadding: CGFloat? = nil,
                footer: String? = nil,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                @ViewModelsContext items: () -> [MvvmViewModel])
    {
        self.id = id
        self.header = .init(header)
        self.headerTopPadding = headerTopPadding
        self.footer = .init(footer)
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items()
    }

    public init(id: String,
                header: AnyPublisher<String, Never>?,
                headerTopPadding: CGFloat? = nil,
                footer: AnyPublisher<String, Never>?,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                items: [MvvmViewModel])
    {
        self.id = id
        self.header = header
        self.headerTopPadding = headerTopPadding
        self.footer = footer
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items
    }

    public init(id: String,
                header: AnyPublisher<String, Never>?,
                headerTopPadding: CGFloat? = nil,
                footer: AnyPublisher<String, Never>?,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                @ViewModelsContext items: () -> [MvvmViewModel])
    {
        self.id = id
        self.header = header
        self.headerTopPadding = headerTopPadding
        self.footer = footer
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items()
    }
}

@available(iOS 13.0, *)
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
