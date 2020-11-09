//
//  UIVisualEffectExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/11/9.
//  Copyright © 2020 Marc Steven(https://marcsteven.top). All rights reserved.
//

import UIKit


public extension UIVisualEffectView {
    convenience init(style:UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        self.init(effect:effect)
    }
}
