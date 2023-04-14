//
//  MvvmCollectionViewCell.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 07.04.2023.
//

import RxSwift
import UIKit

open class MvvmCollectionViewCell<ViewModel: MvvmViewModelProtocol>: UICollectionViewCell, MvvmCollectionViewCellProtocol {
    public private(set) var disposeBag = DisposeBag()

    public override class var reusableId: String { classNameWithoutGenericType }

    public init() {
        super.init(frame: .zero)
        commonInit()
        initSetup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        initSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        initSetup()
    }

    private func commonInit() {
        guard Bundle.main.path(forResource: Self.classNameWithoutGenericType, ofType: "nib") != nil
        else { return }

        contentView.preservesSuperviewLayoutMargins = true
        let nib = Bundle.main.loadNibNamed(Self.classNameWithoutGenericType, owner: self)
        if let view = nib?.first as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.preservesSuperviewLayoutMargins = true
            view.backgroundColor = .clear
            contentView.addSubview(view)

            NSLayoutConstraint.activate([
                view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                view.topAnchor.constraint(equalTo: contentView.topAnchor),
                contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
                contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }

    open func initSetup() {}

    open func setup(with viewModel: ViewModel) {}

    override public func prepareForReuse() {
        super.prepareForReuse()
        resetBundings()
    }

    public func resetBundings() {
        disposeBag = DisposeBag()
    }
}

internal extension MvvmCollectionViewCell {
    class var classNameWithoutGenericType: String {
        return "\(Self.self)".replacingOccurrences(of: "<\(ViewModel.self)>", with: "")
    }
}
