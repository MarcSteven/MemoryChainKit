//
//  Updatable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public protocol Updatable where Self:UITableViewCell {
    func update(_ builder:UITableViewCellBuilder)
}

