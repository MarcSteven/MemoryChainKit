//
//  UILable+Animatable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/13.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//


import UIKit

public extension UILabel {
    
    
    func animate(font:UIFont,duration:TimeInterval) {
        let oldFrame = frame
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        let newOrigin = frame.origin
        if self.textAlignment == .left || self.textAlignment == .natural {
            frame.origin = oldFrame.origin
        }
        if self.textAlignment == .right {
            frame.origin = CGPoint(x: oldFrame.origin.x + oldFrame.width - frame.width, y: oldFrame.origin.y)
        }
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
}
