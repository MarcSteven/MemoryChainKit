//
//  CAGradientLayer+AnimationChange.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/11/13.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import UIKit


public extension CAGradientLayer
{
    func animateChanges(to colors: [UIColor],
                        duration: TimeInterval)
    {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            // Set to final colors when animation ends
            self.colors = colors.map{ $0.cgColor }
        })
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = duration
        animation.toValue = colors.map{ $0.cgColor }
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        add(animation, forKey: "changeColors")
        CATransaction.commit()
    }
}
