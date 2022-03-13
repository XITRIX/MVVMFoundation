//
//  MvvmTabsViewModel.swift
//  ReManga
//
//  Created by Даниил Виноградов on 06.11.2021.
//

import Foundation
import Bond

public struct MvvmTabItem {
    public let item: MvvmViewModel.Type
    public let title: String?
    public let image: UIImage?
    public let selectedImage: UIImage?

    public init(item: MvvmViewModel.Type, title: String?, image: UIImage?, selectedImage: UIImage?) {
        self.item = item
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
}

public protocol MvvmTabsViewModelProtocol: MvvmViewModelProtocol {
    var viewModels: MutableObservableCollection<[MvvmTabItem]> { get }

    func setModels(_ models: [MvvmTabItem])
}

open class MvvmTabsViewModel: MvvmViewModel, MvvmTabsViewModelProtocol {
    public let viewModels = MutableObservableCollection<[MvvmTabItem]>([])

    public func setModels(_ models: [MvvmTabItem]) {
        viewModels.replace(with: models)
    }
}
