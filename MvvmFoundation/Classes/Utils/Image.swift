//
//  Image.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 04.05.2023.
//

import RxSwift
import UIKit

public struct Image {
    let variant: Variant
    var tint: UIColor?

    enum Variant {
        case local(name: String)
        case system(name: String)
        case remote(url: String)
    }

    public static func local(name: String) -> Self {
        .init(variant: .local(name: name))
    }

    public static func system(name: String) -> Self {
        .init(variant: .system(name: name))
    }

    public static func remote(url: String) -> Self {
        .init(variant: .remote(url: url))
    }

    public func with(tint color: UIColor) -> Self {
        var copy = self
        copy.tint = color
        return copy
    }

    fileprivate var image: UIImage? {
        var image: UIImage?

        switch self.variant {
        case .local(let name):
            image = UIImage(named: name)
        case .system(let name):
            image = UIImage(systemName: name)
        case .remote:
            image = nil
        }

        if let tint {
            image = image?.withTintColor(tint, renderingMode: .alwaysOriginal)
        }

        return image
    }
}

public extension UIImageView {
    func setImage(_ image: Image) {
        self.image = image.image
    }
}

public extension Reactive where Base: UIImageView {
    func setImage() -> Binder<Image?> {
        Binder(self.base) { base, image in
            guard let image else {
                base.image = nil
                return
            }

            base.setImage(image)
        }
    }

    func setImageWithVisibility() -> Binder<Image?> {
        Binder(self.base) { base, image in
            base.isHidden = image == nil

            guard let image else {
                base.image = nil
                return
            }

            base.setImage(image)
        }
    }
}
