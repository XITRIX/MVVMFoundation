//
//  MvvmCollectionView.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import Combine
import UIKit

@available(iOS 14.0, *)
public class MvvmCollectionView: UICollectionView {
    public var diffDataSource: MvvmCollectionViewDataSource!
    public var mvvmCollectionViewLayout: MvvmCollectionViewLayout! { collectionViewLayout as? MvvmCollectionViewLayout }

    private let disposeBag = DisposeBag()
    private var keyboardHandler: KeyboardHandler?
    private var longPressRecognizer: UILongPressGestureRecognizer!

    public let sections = PassthroughRelay<[MvvmCollectionSectionModel]>()

    public var contextMenuConfigurationForItemsAt: ((_ indexPaths: [IndexPath], _ point: CGPoint) -> UIContextMenuConfiguration?)?
    public var willPerformPreviewActionForMenuWith: ((_ configuration: UIContextMenuConfiguration, _ animator: any UIContextMenuInteractionCommitAnimating) -> ())?

    @Published public var selectedIndexPaths: [IndexPath] = []

    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        setup()
    }

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public func reloadData() {
        super.reloadData()
    }

    public override var isEditing: Bool {
        get { super.isEditing }
        set {
            super.isEditing = newValue
            selectedIndexPaths = indexPathsForSelectedItems ?? []
        }
    }
}

@available(iOS 14.0, *)
extension MvvmCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPaths = collectionView.indexPathsForSelectedItems ?? []

        guard !isEditing else { return }
        let item = diffDataSource.snapshot().sectionIdentifiers[indexPath.section].items[indexPath.item]
        diffDataSource.modelSelected.send(item)
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedIndexPaths = collectionView.indexPathsForSelectedItems ?? []
    }

    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        guard !isEditing else { return true }
        return diffDataSource.snapshot().sectionIdentifiers[indexPath.section].items[indexPath.item].canBeSelected
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard !isEditing else { return true }
        return diffDataSource.snapshot().sectionIdentifiers[indexPath.section].items[indexPath.item].canBeSelected
    }

    public func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        contextMenuConfigurationForItemsAt?(indexPaths, point)
    }

    public func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: any UIContextMenuInteractionCommitAnimating) {
        willPerformPreviewActionForMenuWith?(configuration, animator)
    }
}

@available(iOS 14.0, *)
private extension MvvmCollectionView {
    func setup() {
        keyboardHandler = .init(self)
        diffDataSource = MvvmCollectionViewDataSource(collectionView: self)

        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        longPressRecognizer.delegate = self
        addGestureRecognizer(longPressRecognizer)

        collectionViewLayout = MvvmCollectionViewLayout(diffDataSource)
        dataSource = diffDataSource
        delegate = self

        disposeBag.bind {
            sections.sink { [unowned self] sections in
                diffDataSource.applyModels(sections) {
                    selectedIndexPaths = indexPathsForSelectedItems ?? []
                }
            }

            diffDataSource.modelSelected.sink { model in
                guard let selectable = model as? MvvmSelectableProtocol
                else { return }

                selectable.selectAction?()
            }
        }
    }

    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        guard longPressGestureRecognizer.state == .began else { return }
        let touchPoint = longPressGestureRecognizer.location(in: self)

        guard let indexPath = indexPathForItem(at: touchPoint)
        else { return }

        let item = diffDataSource.snapshot().sectionIdentifiers[indexPath.section].items[indexPath.item]
//        guard item.canBeLongPressed else { return }

        (item as? MvvmLongPressProtocol)?.longPressAction?()
    }
}

@available(iOS 14.0, *)
extension MvvmCollectionView: UIGestureRecognizerDelegate {
    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == longPressRecognizer
        else { return super.gestureRecognizerShouldBegin(gestureRecognizer) }

        let touchPoint = gestureRecognizer.location(in: self)

        guard let indexPath = indexPathForItem(at: touchPoint)
        else { return false }

        let item = diffDataSource.snapshot().sectionIdentifiers[indexPath.section].items[indexPath.item]
        return item.canBeLongPressed
    }
}
