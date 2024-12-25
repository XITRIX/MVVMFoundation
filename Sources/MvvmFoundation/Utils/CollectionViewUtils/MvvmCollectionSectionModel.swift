//
//  MvvmCollectionSectionModel.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit
import Combine

@available(iOS 13.0, *)
public struct MvvmCollectionSectionModel: Hashable, @unchecked Sendable {
    public enum Style {
        case plain
        case grouped
        case insetGrouped
        case sidebar
        case sidebarPlain
        case platformPlain
    }

    public enum HeaderMode {
        case none
        case supplementary
        case firstItemInSection
    }

    public enum FooterMode {
        case none
        case supplementary
    }

    public let id: String

    public var header: AnyPublisher<String, Never>?
    public var headerTopPadding: CGFloat?
    public var headerMode: HeaderMode
    public var footer: AnyPublisher<String, Never>?
    public var footerMode: FooterMode

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
                headerMode: HeaderMode = .none,
                footer: String? = nil,
                footerMode: FooterMode = .none,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                items: [MvvmViewModel])
    {
        self.id = id
        self.header = .init(header)
        self.headerTopPadding = headerTopPadding
        self.headerMode = headerMode
        self.footer = .init(footer)
        self.footerMode = footerMode
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items
    }

    public init(id: String,
                header: String? = nil,
                headerTopPadding: CGFloat? = nil,
                headerMode: HeaderMode = .none,
                footer: String? = nil,
                footerMode: FooterMode = .none,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                @ViewModelsContext items: () -> [MvvmViewModel])
    {
        self.id = id
        self.header = .init(header)
        self.headerTopPadding = headerTopPadding
        self.headerMode = headerMode
        self.footer = .init(footer)
        self.footerMode = footerMode
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items()
    }

    public init(id: String,
                header: AnyPublisher<String, Never>?,
                headerTopPadding: CGFloat? = nil,
                headerMode: HeaderMode = .none,
                footer: AnyPublisher<String, Never>?,
                footerMode: FooterMode = .none,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                items: [MvvmViewModel])
    {
        self.id = id
        self.header = header
        self.headerTopPadding = headerTopPadding
        self.headerMode = headerMode
        self.footer = footer
        self.footerMode = footerMode
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items
    }

    public init(id: String,
                header: AnyPublisher<String, Never>?,
                headerTopPadding: CGFloat? = nil,
                headerMode: HeaderMode = .none,
                footer: AnyPublisher<String, Never>?,
                footerMode: FooterMode = .none,
                style: MvvmCollectionSectionModel.Style = .insetGrouped,
                showsSeparators: Bool = true,
                backgroundColor: UIColor? = .clear,
                @ViewModelsContext items: () -> [MvvmViewModel])
    {
        self.id = id
        self.header = header
        self.headerTopPadding = headerTopPadding
        self.headerMode = headerMode
        self.footer = footer
        self.footerMode = footerMode
        self.style = style
        self.showsSeparators = showsSeparators
        self.backgroundColor = backgroundColor
        self.items = items()
    }
}

@available(iOS 13.0, *)
@resultBuilder
public enum ViewModelsContext {
    public static func buildBlock() -> [MvvmViewModel] { [] }

    public static func buildBlock(_ components: MvvmViewModel...) -> [MvvmViewModel] {
        components
    }

    public static func buildBlock(_ components: [MvvmViewModel]) -> [MvvmViewModel] {
        components
    }

    public static func buildBlock(_ components: [MvvmViewModel]...) -> [MvvmViewModel] {
        components.flatMap { $0 }
    }

    public static func buildBlock(_ components: [[MvvmViewModel]]) -> [MvvmViewModel] {
        components.flatMap { $0 }
    }

    public static func buildEither(first component: [MvvmViewModel]) -> [MvvmViewModel] {
        component
    }

    public static func buildEither(second component: [MvvmViewModel]) -> [MvvmViewModel] {
        component
    }

    public static func buildOptional(_ component: [MvvmViewModel]?) -> [MvvmViewModel] {
        component ?? []
    }

    public static func buildExpression(_ expression: [MvvmViewModel?]) -> [MvvmViewModel] {
        expression.compactMap { $0 }
    }

    public static func buildExpression(_ expression: MvvmViewModel) -> [MvvmViewModel] {
        [expression]
    }

    public static func buildExpression(_ expression: MvvmViewModel?) -> [MvvmViewModel] {
        expression.map { [$0] } ?? []
    }
}
