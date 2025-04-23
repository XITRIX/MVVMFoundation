//
//  MvvmTabBarViewModel.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 12.04.2023.
//

import RxRelay
import UIKit

public struct MvvmTabBarItem {
    let viewModel: any MvvmViewModelProtocol
    let image: UIImage
    let selectedImage: UIImage?

    public init(viewModel: any MvvmViewModelProtocol, image: UIImage, selectedImage: UIImage? = nil) {
        self.viewModel = viewModel
        self.image = image
        self.selectedImage = selectedImage
    }
}

public protocol MvvmTabBarViewModelProtocol: MvvmViewModelProtocol {
    var tabs: BehaviorRelay<[MvvmTabBarItem]> { get }
}

open class MvvmTabBarViewModel: MvvmViewModel, MvvmTabBarViewModelProtocol {
    public let tabs = BehaviorRelay<[MvvmTabBarItem]>(value: [])
}
