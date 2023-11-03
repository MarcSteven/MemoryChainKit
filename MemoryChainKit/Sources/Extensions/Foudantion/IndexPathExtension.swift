//
//  IndexPathExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

extension IndexPath {
    public static var zero: IndexPath {
        .init(item: 0, section: 0)
    }

    public func with(_ globalSection: Int) -> IndexPath {
        .init(row: row, section: globalSection + section)
    }
}

extension IndexPath {
    public func previous() -> IndexPath? {
        guard item > 0 else {
            return nil
        }

        return IndexPath(row: item - 1, section: section)
    }

    public func next(in collectionView: UICollectionView) -> IndexPath? {
        let itemsInSection = collectionView.numberOfItems(inSection: section)

        guard item + 1 < itemsInSection else {
            return nil
        }

        return IndexPath(row: item + 1, section: section)
    }

    public func next(in tableView: UITableView) -> IndexPath? {
        let rowsInSection = tableView.numberOfRows(inSection: section)

        guard row + 1 < rowsInSection else {
            return nil
        }

        return IndexPath(row: row + 1, section: section)
    }
}
