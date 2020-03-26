//
//  MCTableViewCell.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/26.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

open class MCTableViewCell:UITableViewCell {
    
    //MARK: - init methods
    public convenience init() {
        self.init(style:.default,reuseIdentifier:nil)
    }
    public required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        
    }
    private func internalCommonInit() {
        backgroundColor = .clear
        commonInit()
    }
    open func commonInit() {}

}
