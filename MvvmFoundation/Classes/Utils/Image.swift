//
//  Image.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 04.05.2023.
//

import RxSwift
import UIKit

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
        case .remote:
            break
        }
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
