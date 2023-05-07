//
//  Image.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 04.05.2023.
//

import UIKit
import RxSwift

public enum Image {
    case local(name: String)
    case system(name: String)
    case remote(url: String)
}

public extension UIImageView {
    func setImage(_ image: Image) {
        switch image {
        case .local(let name):
            self.image = UIImage(named: name)
        case .system(let name):
            self.image = UIImage(systemName: name)
        case .remote(_):
            break
        }
    }
}


extension Reactive where Base: UIImageView {
    public func setImage() -> Binder<Image?> {
        Binder(self.base) { imageView, image in
            guard let image else {
                base.image = nil
                return
            }

            base.setImage(image)
        }
    }
}
