//
//  UIControl+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/31.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

public extension UIControl {
    func set(_ anchorPoint:CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * anchorPoint.x, y: bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(bounds.size.width * layer.anchorPoint.x, bounds.size.height * layer.anchorPoint.y)
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        var position = layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        layer.position = position
        layer.anchorPoint = anchorPoint
        
    }
}
