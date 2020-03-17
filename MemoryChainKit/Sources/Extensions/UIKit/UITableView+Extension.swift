//
//  UITableView+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/31.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public extension UITableView {
    func scrollToLastRow() {
        let indexPath = IndexPath(row:0,section: 0)
        self.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    func scrollToSelectedRow() {
        let selectedRows = self.indexPathsForVisibleRows
        if let selectedRow = selectedRows?[0] as NSIndexPath? {
            self.scrollToRow(at: selectedRow as IndexPath, at: .middle, animated: true)
        }
    }
    func scrollToHeader() {
        self.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    func removeEliminateExtraSeparators() {
        self.tableFooterView = UIView(frame: .zero)
        self.tableHeaderView = UIView(frame:.zero)
    }
    func registerCell(_ cellTypes:[AnyClass]) {
        for cellType in cellTypes {
            let typeString = String(describing: cellType)
            let xibPath = Bundle(for: cellType).path(forResource: typeString, ofType: ".nib")
            if xibPath == nil {
                register(cellType, forCellReuseIdentifier: typeString)
            } else {
                register(UINib(nibName: typeString, bundle: nil), forCellReuseIdentifier: typeString)
            }
        }
    }
}
