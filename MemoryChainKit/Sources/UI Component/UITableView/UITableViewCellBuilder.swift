//
//  UITableViewCellBuilder.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit


public protocol UITableViewCellBuilder {
    var cellType:UpdatableCell.Type {get}
    var rowHeight:CGFloat {get}
    func build(_ cell:UpdatableCell)
    
}

public extension UITableViewCellBuilder {
    var rowHeight:CGFloat {
        return UITableView.automaticDimension
    }
    func build(_ cell:UpdatableCell) {
        cell.update(self)
    }
}
