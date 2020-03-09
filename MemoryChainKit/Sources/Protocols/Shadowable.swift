//
//  Shadowable.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public protocol Shadowable:AnyObject {}

public extension Shadowable where Self:UIView {
    var shadowColor:UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.masksToBounds = false
            layer.shadowColor = newValue?.cgColor
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
}

extension Shadowable {
    func updateColor() {
        
    }
}
