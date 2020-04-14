//
//  UITableView+Reusable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UITableView {
        func register(_ type: UpdatableCell.Type) {
            register(type, forCellReuseIdentifier: String(describing: type))
        }
        
        func dequeueReusableCell(_ type: UpdatableCell.Type) -> UpdatableCell {
            let identifier = String(describing: type)
            guard let cell = dequeueReusableCell(withIdentifier: identifier) as? UpdatableCell else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(identifier) matching type \(type.self)."
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
        }
}
