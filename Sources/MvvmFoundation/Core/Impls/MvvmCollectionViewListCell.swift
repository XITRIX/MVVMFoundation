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

    private var _viewModel: ViewModel!
    public private(set) var viewModel: ViewModel {
        get { _viewModel}
        set { _viewModel = newValue }
    }

    open var attachCellToContentView: Bool { true }

    override public class var reusableId: String { classNameWithoutGenericType }

    private var minimumSystemHeightMarginValue: Double {
#if os(visionOS)
        10
#else
        8
#endif
    }

    open var cellRespectsSystemMinimumHeight: Bool = true {
        didSet { layoutMarginsDidChange() }
    }

    public init() {
        super.init(frame: .zero)
        commonInit()
        initSetup()
    }

    override public init(frame: CGRect) {
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

    // Free bindings on cell reuse
    override public func prepareForReuse() {
        super.prepareForReuse()
        resetBundings()
    }

    // Free attached viewModel and bindings if cell went into reusable stash
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview == nil {
            resetBundings()
            _viewModel = nil
        }
    }

    public func resetBundings() {
        disposeBag = DisposeBag()
    }

    public func setViewModel(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    open override var layoutMargins: UIEdgeInsets {
        get {
            var res = super.layoutMargins
            if cellRespectsSystemMinimumHeight {
                res.top = minimumSystemHeightMarginValue
                res.bottom = minimumSystemHeightMarginValue
            }
            return res
        }
        set {
            super.layoutMargins = newValue
        }
    }
}

@available(iOS 14.0, *)
internal extension MvvmCollectionViewListCell {
    class var classNameWithoutGenericType: String {
        return "\(Self.self)".replacingOccurrences(of: "<\(ViewModel.self)>", with: "")
    }
}
