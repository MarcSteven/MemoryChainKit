//
//  UITableView+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/31.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public extension UITableView {
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
