//
//  MvvmTableViewCell.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import RxSwift
import UIKit

public struct MvvmCellViewModelWrapper<ViewModel: MvvmViewModelProtocol>: Hashable {
    public let viewModel: ViewModel!

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

open class MvvmTableViewCell<ViewModel: MvvmViewModelProtocol>: UITableViewCell, MvvmTableViewCellProtocol {
    public private(set) var disposeBag = DisposeBag()
    private(set) public var viewModel: ViewModel!

    public override class var reusableId: String { classNameWithoutGenericType }

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        guard Bundle.main.path(forResource: Self.classNameWithoutGenericType, ofType: "nib") != nil
        else { return }

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

    open func setup(with viewModel: ViewModel) {}

    override public func prepareForReuse() {
        super.prepareForReuse()
        resetBundings()
    }

    public func resetBundings() {
        disposeBag = DisposeBag()
    }

    public func setViewModel(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

internal extension MvvmTableViewCell {
    class var classNameWithoutGenericType: String {
        return "\(Self.self)".replacingOccurrences(of: "<\(ViewModel.self)>", with: "")
    }
}
