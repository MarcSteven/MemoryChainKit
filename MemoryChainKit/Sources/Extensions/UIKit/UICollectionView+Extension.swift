//
//  UICollectionView+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/30.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//


import UIKit

public extension UICollectionView {
    
    func numberOfRows(using delegate:UIViewController & UICollectionViewDelegateFlowLayout) ->Int {
        let layout = (collectionViewLayout as? UICollectionViewFlowLayout)!
        var totalNumberOfItems = 0
        for section in 0...numberOfSections - 1 {
            totalNumberOfItems += numberOfItems(inSection: section)
            
        }
        let insets = layout.sectionInset
        let width = bounds.width - insets.left - insets.right
        let indexPath = IndexPath(row: 0, section: 0)
        let cellWidth = delegate.collectionView!(self, layout: layout, sizeForItemAt: indexPath).width
        let cellSpacing = layout.minimumLineSpacing
        let numberOfItemsInRow = floor(width / (cellWidth + cellSpacing))
        let numberOfRows = ceil(CGFloat(totalNumberOfItems) / numberOfItemsInRow)
        return Int(numberOfRows)
        
    }
}

extension UICollectionView {
    /// Returns all the cells of the collection view in the given visible section.
    ///
    /// - Parameter section: The index of the section for which you want a count of the items.
    /// - Returns: The cell objects at the corresponding section or nil if the section is not visible or indexPath is out of range.
    ///
    /// - Note: Only the visible cells are returned.
    open func cells(inSection section: Int) -> [UICollectionViewCell] {
        guard section < numberOfSections else {
            return []
        }

        var cells: [UICollectionViewCell] = []

        for item in 0..<numberOfItems(inSection: section) {
            guard let cell = cellForItem(at: IndexPath(item: item, section: section)) else {
                continue
            }

            cells.append(cell)
        }

        return cells
    }

    /// Returns the first cell of the collection view that satisfies the given
    /// predicate.
    ///
    /// The following example uses the `cell(where:)` method to find the first
    /// cell of class type `PhotoCell`:
    ///
    /// ```swift
    /// if let cell = collectionView.cell(where: { $0.isKind(of: PhotoCell.self) }) {
    ///     print("Found cell of type PhotoCell.")
    /// }
    /// ```
    ///
    /// - Parameter predicate: A closure that takes a cell of the collection view as
    ///   its argument and returns a boolean value indicating whether the
    ///   element is a match.
    /// - Returns: The first cell of the collection view that satisfies `predicate`,
    ///   or `nil` if there is no cell that satisfies `predicate`.
    ///
    /// - Note: Only the visible cells are queried.
    open func cell(where predicate: (UICollectionViewCell) -> Bool) -> UICollectionViewCell? {
        for section in 0..<numberOfSections {
            for item in 0..<numberOfItems(inSection: section) {
                guard let cell = cellForItem(at: IndexPath(item: item, section: section)) else {
                    continue
                }

                if predicate(cell) {
                    return cell
                }
            }
        }

        return nil
    }

    /// Returns the first cell of the collection view that satisfies the given
    /// type `T`.
    ///
    /// ```swift
    /// if let cell = collectionView.cell(kind: PhotoCell.self) {
    ///     print("Found cell of type PhotoCell.")
    /// }
    /// ```
    ///
    /// - Parameter kind: The kind of cell to find.
    /// - Returns: The first cell of the collection view that satisfies the given,
    ///   type or `nil` if there is no cell that satisfies the type `T`.
    open func cell<T: UICollectionViewCell>(kind: T.Type) -> T? {
        cell { $0.isKind(of: kind) } as? T
    }
}

