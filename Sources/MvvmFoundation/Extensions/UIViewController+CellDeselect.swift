//
//  UIViewController+CellDeselect.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import UIKit

public extension UIViewController {
    /// Smoothly deselect UITableView's Cells like in native UITableViewController.
    ///
    /// Has to be called from viewWillAppear function.
    func smoothlyDeselectRows(in tableView: UITableView) {
        // Get the initially selected index paths, if any
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows
        else { return }

        // Grab the transition coordinator responsible for the current transition
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: { context in
                selectedIndexPaths.forEach {
                    tableView.deselectRow(at: $0, animated: context.isAnimated)
                }
            }) { context in
                if context.isCancelled {
                    selectedIndexPaths.forEach {
                        tableView.selectRow(at: $0, animated: false, scrollPosition: .none)
                    }
                }
            }
        }
        else { // If this isn't a transition coordinator, just deselect the rows without animating
            selectedIndexPaths.forEach {
                tableView.deselectRow(at: $0, animated: false)
            }
        }
    }

    /// Smoothly deselect UITableView's Cells like in native UITableViewController.
    ///
    /// Has to be called from viewWillAppear function.
    func smoothlyDeselectRows(in collectionView: UICollectionView) {
        // Get the initially selected index paths, if any
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems
        else { return }

        // Grab the transition coordinator responsible for the current transition
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: { context in
                selectedIndexPaths.forEach {
                    collectionView.deselectItem(at: $0, animated: context.isAnimated)
                }
            }) { context in
                if context.isCancelled {
                    selectedIndexPaths.forEach {
                        collectionView.selectItem(at: $0, animated: false, scrollPosition: [])
                    }
                }
            }
        }
        else { // If this isn't a transition coordinator, just deselect the rows without animating
            selectedIndexPaths.forEach {
                collectionView.deselectItem(at: $0, animated: false)
            }
        }
    }
}
