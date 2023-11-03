//
//  IndicatorView.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/7/28.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

open class IndicatorView:UIView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
    override open func tintColorDidChange() {
        super.tintColorDidChange()
        self.backgroundColor = tintColor
    }
    
}
