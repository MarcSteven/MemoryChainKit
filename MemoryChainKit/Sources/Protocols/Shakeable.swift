//
//  Shakeable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/8.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

protocol Shakeable { }


extension Shakeable where Self:UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0 , y: self.center.y))
        animation.toValue = NSValue(cgPoint:CGPoint(x: self.center.x + 4.0, y: self.center.y))
        layer.add(animation, forKey: "position")
        
    }
}
