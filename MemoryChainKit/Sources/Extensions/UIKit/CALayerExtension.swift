//
//  CALayerExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

public extension CALayer {
    func applyAnimation(animation:CABasicAnimation) {
        let copy = animation.copy() as! CABasicAnimation
        if copy.fromValue == nil {
            copy.fromValue = self.presentation()?.value(forKeyPath: copy.keyPath!)
        }
        self.add(copy, forKey: copy.keyPath)
        self.setValue(copy.toValue, forKey: copy.keyPath!)
    }
}
