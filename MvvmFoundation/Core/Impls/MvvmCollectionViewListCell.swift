//
//  MvvmCollectionViewListCell.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 04/11/2023.
//

import Combine
import UIKit

@available(iOS 14.0, *)
open class MvvmCollectionViewListCell<ViewModel: MvvmViewModelProtocol>: UICollectionViewListCell, MvvmCollectionViewCellProtocol {
    public private(set) var disposeBag = DisposeBag()
    private(set) public var viewModel: ViewModel = .init()
    open var attachCellToContentView: Bool { true }

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
            let targetContainer = attachCellToContentView ? contentView : self

            view.translatesAutoresizingMaskIntoConstraints = false
            view.preservesSuperviewLayoutMargins = true
            view.backgroundColor = .clear
            targetContainer.addSubview(view)

            NSLayoutConstraint.activate([
                view.leftAnchor.constraint(equalTo: targetContainer.leftAnchor),
                view.topAnchor.constraint(equalTo: targetContainer.topAnchor),
                targetContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
                targetContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

    public func setViewModel(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

@available(iOS 14.0, *)
internal extension MvvmCollectionViewListCell {
    class var classNameWithoutGenericType: String {
        return "\(Self.self)".replacingOccurrences(of: "<\(ViewModel.self)>", with: "")
    }
}
